const warn = @import("std").debug.warn;
const std = @import("std");
const pb = @import("protobuf");
const plugin = @import("google/protobuf/compiler/plugin.pb.zig");
const descriptor = @import("google/protobuf/descriptor.pb.zig");
const mem = std.mem;
const FullName = @import("./FullName.zig").FullName;

const USE_MODULES = false;

const allocator = std.heap.page_allocator;

const string = []const u8;

pub const std_options: std.Options = .{ .log_scope_levels = &[_]std.log.ScopeLevel{.{ .level = .warn, .scope = .zig_protobuf }} };

pub fn main() !void {
    // Read the contents (up to 10MB)
    const buffer_size = 1024 * 1024 * 10;

    const stdin = std.io.getStdIn();
    const file_buffer = try stdin.readToEndAlloc(allocator, buffer_size);
    defer allocator.free(file_buffer);

    const request: plugin.CodeGeneratorRequest = try plugin.CodeGeneratorRequest.decode(file_buffer, allocator);

    var ctx: GenerationContext = GenerationContext{ .allocator = allocator, .req = request };

    try ctx.processRequest();
    const r = try ctx.res.encode(allocator);

    const stdout = std.io.getStdOut();
    _ = try stdout.write(r);
}

const GenerationContext = struct {
    allocator: std.mem.Allocator,
    req: plugin.CodeGeneratorRequest,
    res: plugin.CodeGeneratorResponse = .{},

    /// map of known packages
    known_packages: std.StringHashMap(FullName) = std.StringHashMap(FullName).init(allocator),

    imports_map: std.StringHashMap(Import) = std.StringHashMap(Import).init(allocator),

    basic_types: std.StringHashMap(BasicType) = std.StringHashMap(BasicType).init(allocator),

    /// map of "package.fully.qualified.names" to output string lists (aka files)
    output_lists: std.AutoHashMap(*const descriptor.FileDescriptorProto, std.ArrayList([]const u8)) = std.AutoHashMap(*const descriptor.FileDescriptorProto, std.ArrayList([]const u8)).init(allocator),

    const Self = @This();
    const BasicType = enum { resolving, basic, complex };
    const Import = struct {
        file: *const descriptor.FileDescriptorProto,
        descriptor: ?*const descriptor.DescriptorProto,
    };

    pub fn processRequest(self: *Self) !void {
        for (self.req.proto_file.items) |*file| {
            if (file.package) |package| {
                try self.known_packages.put(package.getSlice(), FullName{ .buf = package.getSlice() });
            } else {
                self.res.@"error" = pb.ManagedString{ .Owned = try std.fmt.allocPrint(allocator, "ERROR Package directive missing in {?s}\n", .{file.name.?.getSlice()}) };
                return;
            }

            try self.imports_map.ensureTotalCapacity(1000);
            var prefix = try std.ArrayList(u8).initCapacity(allocator, file.package.?.getSlice().len + 128);
            prefix.appendAssumeCapacity('.');
            prefix.appendSliceAssumeCapacity(file.package.?.getSlice());
            try self.registerMessages(file, &prefix, file.enum_type.items);
            try self.registerMessages(file, &prefix, file.message_type.items);
            try self.basic_types.ensureTotalCapacity(self.imports_map.count());
        }

        for (self.req.proto_file.items) |*file| {
            const name = FullName{ .buf = file.name.?.getSlice() };
            try self.printFileDeclarations(name, file);
        }

        var it = self.output_lists.iterator();
        while (it.next()) |entry| {
            var ret = plugin.CodeGeneratorResponse.File.init();

            const pb_name = try self.outputFileName(entry.key_ptr.*);
            ret.name = pb.ManagedString.move(pb_name, allocator);
            ret.content = pb.ManagedString.move(try std.mem.concat(allocator, u8, entry.value_ptr.*.items), allocator);
            try self.res.file.append(allocator, ret);
        }

        self.res.supported_features = @intFromEnum(plugin.CodeGeneratorResponse.Feature.FEATURE_PROTO3_OPTIONAL);
    }

    fn outputFileName(self: *Self, file: *const descriptor.FileDescriptorProto) !string {
        var n = file.name.?.getSlice();
        if (std.mem.endsWith(u8, n, ".proto")) n = n[0 .. n.len - ".proto".len];

        return try std.fmt.allocPrint(self.allocator, "{s}.pb.zig", .{n});
    }

    fn fileNameFromPackage(self: *Self, package: string) !string {
        return try std.fmt.allocPrint(allocator, "{s}.pb.zig", .{try self.packageNameToOutputFileName(package)});
    }

    fn packageNameToOutputFileName(_: *Self, name: string) !string {
        var r: []u8 = try allocator.alloc(u8, name.len);
        var n = name;
        if (std.mem.endsWith(u8, n, ".proto")) n = name[0 .. n.len - ".proto".len];
        for (n, 0..) |byte, i| {
            r[i] = switch (byte) {
                '.', '/', '\\' => '/',
                else => byte,
            };
        }
        return r[0..n.len];
    }

    fn getOutputList(self: *Self, file: *const descriptor.FileDescriptorProto) !*std.ArrayList([]const u8) {
        const entry = try self.output_lists.getOrPut(file);
        if (entry.found_existing) return entry.value_ptr;

        var list = std.ArrayList([]const u8).init(self.allocator);

        try list.append(try std.fmt.allocPrint(self.allocator,
            \\ ///! package {?}
            \\ ///! Code generated by zig-protobuf fork !
            \\const std = @import("std");
            \\const Allocator = std.mem.Allocator;
            \\const ArrayListU = std.ArrayListUnmanaged;
            \\
            \\const protobuf = @import("protobuf");
            \\const ManagedString = protobuf.ManagedString;
            \\const fd = protobuf.fd;
            \\
            \\test {{
            \\    std.testing.refAllDeclsRecursive(@This());
            \\}}
            \\
        , .{file.package}));

        file_deps: for (file.dependency.items) |dep_name| {
            for (self.req.proto_file.items, 0..) |dep, index| {
                if (!std.mem.eql(u8, dep_name.getSlice(), dep.name.?.getSlice()))
                    continue;

                // find whether an import is marked as public
                const is_public_dep = std.mem.indexOfScalar(i32, file.public_dependency.items, @intCast(index));
                const optional_pub_directive: []const u8 = if (is_public_dep) |_| "pub const" else "const";

                try list.append(try std.fmt.allocPrint(self.allocator, "/// import package {?}\n", .{dep.package}));
                // Generate a flat list of imports.
                // const google_protobuf_descriptor = @import("google_protobuf_descriptor_proto");
                // This is not very nice and could trigger conflicts with other names in the code.
                // Ideally we should generate
                // const google = struct {
                //     pub const protobuf = struct {
                //         usingnamespace @import("google_protobuf_descriptor_proto");
                //     };
                // };
                // This is a bit more involved because we need to merge different imports in one struct.
                const import_name = try self.importName(dep.name.?.getSlice());
                const import_path = self.resolvePath(file.name.?.getSlice(), dep.name.?.getSlice());
                try list.append(try std.fmt.allocPrint(self.allocator, "{s} {!s} = @import(\"{!s}\");\n", .{
                    optional_pub_directive,
                    import_name,
                    if (USE_MODULES) import_name else import_path,
                }));
                continue :file_deps;
            } else {
                std.log.warn("Dependency of {?} not found: {}", .{ file.name, dep_name });
            }
        }

        entry.value_ptr.* = list;
        return entry.value_ptr;
    }

    /// resolves a path B relative to A
    fn resolvePath(self: *Self, a: string, b: string) !string {
        const aPath = std.fs.path.dirname(try self.fileNameFromPackage(a)) orelse "";
        const bPath = try self.fileNameFromPackage(b);

        // to resolve some escaping oddities, the windows path separator is canonicalized to /
        const resolvedRelativePath = try std.fs.path.relative(allocator, aPath, bPath);
        return std.mem.replaceOwned(u8, self.allocator, resolvedRelativePath, "\\", "/");
    }

    pub fn printFileDeclarations(self: *Self, fqn: FullName, file: *descriptor.FileDescriptorProto) !void {
        const list = try self.getOutputList(file);

        try self.generateEnums(list, fqn, file.*, file.enum_type.items);
        try self.generateMessages(list, fqn, file.*, file.message_type.items);
    }

    fn generateEnums(ctx: *Self, list: *std.ArrayList(string), fqn: FullName, file: descriptor.FileDescriptorProto, enums: []const descriptor.EnumDescriptorProto) !void {
        _ = file;

        var enum_values = std.AutoHashMap(i32, void).init(ctx.allocator);
        defer enum_values.deinit();

        for (enums) |theEnum| {
            const e: descriptor.EnumDescriptorProto = theEnum;

            try list.append(try std.fmt.allocPrint(allocator, "\npub const {?s} = enum(i32) {{\n", .{e.name.?.getSlice()}));

            enum_values.clearRetainingCapacity();
            try enum_values.ensureTotalCapacity(@intCast(e.value.items.len));
            for (e.value.items) |elem| {
                const val = elem.number orelse 0;
                const res = try enum_values.getOrPut(val);
                if (res.found_existing) {
                    std.log.warn("ignoring duplicate enum value {s} in {s}.{s}", .{ elem.name.?, fqn.buf, theEnum.name.? });
                } else {
                    try list.append(try std.fmt.allocPrint(allocator, "   {?s} = {},\n", .{ elem.name.?.getSlice(), val }));
                    res.key_ptr.* = val;
                }
            }

            try list.append("    _,\n};\n\n");
        }
    }

    fn getFieldName(_: *Self, field: descriptor.FieldDescriptorProto) !string {
        return escapeName(field.name.?.getSlice());
    }

    fn escapeName(name: string) !string {
        if (std.zig.Token.keywords.get(name) != null)
            return try std.fmt.allocPrint(allocator, "@\"{?s}\"", .{name})
        else
            return name;
    }

    fn fieldTypeFqn(ctx: *Self, parentFqn: FullName, file: descriptor.FileDescriptorProto, field: descriptor.FieldDescriptorProto) !string {
        if (field.type_name) |type_name| {
            const import = ctx.imports_map.get(type_name.getSlice()) orelse {
                // Swallow the error, Zig will generate a better one later when compiling.
                std.log.err("Unknown type: {}", .{type_name});
                return type_name.getSlice()[1..];
            };

            const fullTypeName = FullName{ .buf = type_name.getSlice()[1..] };

            const import_file_name = import.file.name.?.getSlice();
            if (!std.mem.eql(u8, import_file_name, file.name.?.getSlice())) {
                // We need to import from another file
                const fqname = type_name.getSlice()[1 + import.file.package.?.getSlice().len + 1 ..];
                return try std.fmt.allocPrint(ctx.allocator, "{s}.{s}", .{ try ctx.importName(import_file_name), fqname });
            }

            // We are in the file declaring this symbol, so no need to import.
            // But we may need to prefix in case of ambiguity
            if (fullTypeName.parent()) |parent| {
                if (parent.eql(parentFqn)) {
                    return fullTypeName.name().buf;
                }
                if (parent.eql(FullName{ .buf = file.package.?.getSlice() })) {
                    return fullTypeName.name().buf;
                }
            }

            var parent: ?FullName = fullTypeName.parent();
            const filePackage = FullName{ .buf = file.package.?.getSlice() };

            // iterate parents until we find a parent that matches the known_packages
            while (parent != null) {
                var it = ctx.known_packages.valueIterator();

                while (it.next()) |value| {

                    // it is in current package, return full name
                    if (filePackage.eql(parent.?)) {
                        const name = fullTypeName.buf[parent.?.buf.len + 1 ..];
                        return name;
                    }

                    // it is in different package. return fully qualified name including accessor
                    if (value.eql(parent.?)) {
                        const prop = try ctx.escapeFqn(parent.?.buf);
                        const name = fullTypeName.buf[prop.len + 1 ..];
                        return try std.fmt.allocPrint(allocator, "{s}.{s}", .{ prop, name });
                    }
                }

                parent = parent.?.parent();
            }

            std.debug.print("Unknown type: {s} from {s} in {?s}\n", .{ fullTypeName.buf, parentFqn.buf, file.package.?.getSlice() });

            return try ctx.escapeFqn(field.type_name.?.getSlice());
        }
        @panic("field has no type");
    }

    fn escapeFqn(self: *Self, n: string) !string {
        var r: []u8 = try self.allocator.alloc(u8, n.len);
        for (n, 0..) |byte, i| {
            r[i] = switch (byte) {
                '.', '-', '/', '\\' => '_',
                else => byte,
            };
        }
        return r;
    }

    fn importName(self: *Self, name: string) !string {
        const n = name;
        // if (std.mem.endsWith(u8, n, ".proto")) n = n[0 .. n.len - ".proto".len];
        var r: []u8 = try self.allocator.alloc(u8, n.len);
        for (n, 0..) |byte, i| {
            r[i] = switch (byte) {
                '.', '-', '/', '\\' => '_',
                else => byte,
            };
        }
        return r;
    }

    fn isRepeated(field: descriptor.FieldDescriptorProto) bool {
        if (field.label) |l| {
            return l == .LABEL_REPEATED;
        } else {
            return false;
        }
    }

    fn isScalarNumeric(t: descriptor.FieldDescriptorProto.Type) bool {
        return switch (t) {
            .TYPE_DOUBLE, .TYPE_FLOAT, .TYPE_INT32, .TYPE_INT64, .TYPE_UINT32, .TYPE_UINT64, .TYPE_SINT32, .TYPE_SINT64, .TYPE_FIXED32, .TYPE_FIXED64, .TYPE_SFIXED32, .TYPE_SFIXED64, .TYPE_BOOL => true,
            else => false,
        };
    }

    fn isPacked(_: *Self, file: descriptor.FileDescriptorProto, field: descriptor.FieldDescriptorProto) bool {
        const default = if (is_proto3_file(file))
            if (field.type) |t|
                isScalarNumeric(t)
            else
                false
        else
            false;

        if (field.options) |o| {
            if (o.@"packed") |p| {
                return p;
            }
        }
        return default;
    }

    fn isOptional(file: descriptor.FileDescriptorProto, field: descriptor.FieldDescriptorProto) bool {
        if (is_proto3_file(file)) {
            return field.proto3_optional == true or field.type.? == .TYPE_MESSAGE;
        }

        if (field.type.? == .TYPE_MESSAGE) return true;
        if (field.label) |l| {
            return l == .LABEL_OPTIONAL;
        } else {
            return false;
        }
    }

    fn getFieldType(ctx: *Self, fqn: FullName, file: descriptor.FileDescriptorProto, field: descriptor.FieldDescriptorProto, is_union: bool) !string {
        var prefix: string = "";
        var postfix: string = "";
        const repeated = isRepeated(field);
        const t = field.type.?;

        if (repeated) {
            prefix = "ArrayListU(";
            postfix = ")";
        } else if (ctx.isBasicType(field)) {
            if (isOptional(file, field) and !is_union) {
                // with union the option is on the union not on the union fields
                prefix = "?";
            }
        } else {
            // Note: this allows to break protos depending on themselve:
            // `message Foo { Foo x = 1; }` becomes `const Foo = struct { x: ?*const Foo }`
            // But it also means that every message using `Foo` will also pass it by reference, even though only the Foo inside Foo is an issue.
            // We could be more precise, and only pass problematic Foo by pointers.
            prefix = if (is_union) "*const " else "?*const ";
        }

        const infix: string = switch (t) {
            .TYPE_SINT32, .TYPE_SFIXED32, .TYPE_INT32 => "i32",
            .TYPE_UINT32, .TYPE_FIXED32 => "u32",
            .TYPE_INT64, .TYPE_SINT64, .TYPE_SFIXED64 => "i64",
            .TYPE_UINT64, .TYPE_FIXED64 => "u64",
            .TYPE_BOOL => "bool",
            .TYPE_DOUBLE => "f64",
            .TYPE_FLOAT => "f32",
            .TYPE_STRING, .TYPE_BYTES => "ManagedString",
            .TYPE_ENUM, .TYPE_MESSAGE => try ctx.fieldTypeFqn(fqn, file, field),
            else => {
                std.debug.print("Unrecognized type {}\n", .{t});
                @panic("Unrecognized type");
            },
        };
        return try std.mem.concat(allocator, u8, &.{ prefix, infix, postfix });
    }

    fn isBasicType(ctx: *Self, field: descriptor.FieldDescriptorProto) bool {
        // Repeated fields are just pointer.
        if (isRepeated(field)) return true;

        return switch (field.type.?) {
            .TYPE_SINT32, .TYPE_SFIXED32, .TYPE_INT32, .TYPE_UINT32, .TYPE_FIXED32, .TYPE_INT64, .TYPE_SINT64, .TYPE_SFIXED64, .TYPE_UINT64, .TYPE_FIXED64, .TYPE_BOOL, .TYPE_DOUBLE, .TYPE_FLOAT, .TYPE_STRING, .TYPE_BYTES, .TYPE_ENUM => true,
            .TYPE_MESSAGE => {
                const type_name = field.type_name.?.getSlice();
                return ctx.resolveTypeIsBasic(type_name);
            },
            .TYPE_GROUP => @panic("Groups are deprecated and not supported in zig-protobuf"),
            _ => @panic("Unrecognized type"),
        };
    }

    fn resolveTypeIsBasic(self: *Self, type_name: []const u8) bool {
        const res = self.basic_types.getOrPut(type_name) catch unreachable;
        if (res.found_existing) {
            if (res.value_ptr.* == .resolving) {
                // We've found a loop, break it by marking this type as complex.
                res.value_ptr.* = .complex;
                return false;
            }
            return res.value_ptr.* == .basic;
        }
        const desc_file = self.imports_map.get(type_name) orelse {
            std.log.warn("Type not found: {s}", .{type_name});
            res.value_ptr.* = .complex;
            return false;
        };
        const desc: *const descriptor.DescriptorProto = desc_file.descriptor.?;
        // Mark ourselves as resolving to detect loops.
        res.value_ptr.* = .resolving;
        for (desc.field.items) |field| {
            switch (field.type.?) {
                .TYPE_MESSAGE => {
                    // Resolve nested messages.
                    _ = self.resolveTypeIsBasic(field.type_name.?.getSlice());
                },
                else => {},
            }
        }
        // While resolving nested types, we might have marked ourselves as .complex because of a loop.
        // But otherwise we should still be resolving.
        // Indeed if we modify ourselves, it means there was a loop,
        // and that we are complex.
        return switch (res.value_ptr.*) {
            .complex => false,
            .resolving => {
                res.value_ptr.* = .basic;
                return true;
            },
            .basic => unreachable,
        };
    }

    fn getFieldDefault(_: *Self, field: descriptor.FieldDescriptorProto, file: descriptor.FileDescriptorProto, nullable: bool) !?string {
        // ArrayLists need to be initialized
        if (isRepeated(field)) return ".{}";

        const is_proto3 = is_proto3_file(file);

        if (nullable and field.default_value == null) {
            return "null";
        }

        // proto3 does not support explicit default values, the default scalar values are used instead
        if (is_proto3) {
            return switch (field.type.?) {
                .TYPE_SINT32,
                .TYPE_SFIXED32,
                .TYPE_INT32,
                .TYPE_UINT32,
                .TYPE_FIXED32,
                .TYPE_INT64,
                .TYPE_SINT64,
                .TYPE_SFIXED64,
                .TYPE_UINT64,
                .TYPE_FIXED64,
                .TYPE_FLOAT,
                .TYPE_DOUBLE,
                => "0",
                .TYPE_BOOL => "false",
                .TYPE_STRING, .TYPE_BYTES => ".Empty",
                .TYPE_ENUM => "@enumFromInt(0)",
                .TYPE_MESSAGE => ".{}",
                .TYPE_GROUP => @panic("Groups are deprecated and not supported in zig-protobuf"),
                _ => @panic("Unrecognized type"),
            };
        }

        if (field.default_value == null) return null;

        return switch (field.type.?) {
            .TYPE_SINT32, .TYPE_SFIXED32, .TYPE_INT32, .TYPE_UINT32, .TYPE_FIXED32, .TYPE_INT64, .TYPE_SINT64, .TYPE_SFIXED64, .TYPE_UINT64, .TYPE_FIXED64, .TYPE_BOOL => field.default_value.?.getSlice(),
            .TYPE_FLOAT => if (std.mem.eql(u8, field.default_value.?.getSlice(), "inf")) "std.math.inf(f32)" else if (std.mem.eql(u8, field.default_value.?.getSlice(), "-inf")) "-std.math.inf(f32)" else if (std.mem.eql(u8, field.default_value.?.getSlice(), "nan")) "std.math.nan(f32)" else field.default_value.?.getSlice(),
            .TYPE_DOUBLE => if (std.mem.eql(u8, field.default_value.?.getSlice(), "inf")) "std.math.inf(f64)" else if (std.mem.eql(u8, field.default_value.?.getSlice(), "-inf")) "-std.math.inf(f64)" else if (std.mem.eql(u8, field.default_value.?.getSlice(), "nan")) "std.math.nan(f64)" else field.default_value.?.getSlice(),
            .TYPE_STRING, .TYPE_BYTES => if (field.default_value.?.isEmpty())
                ".Empty"
            else
                try std.mem.concat(allocator, u8, &.{ "ManagedString.static(", try formatSliceEscapeImpl(field.default_value.?.getSlice()), ")" }),
            .TYPE_ENUM => try std.mem.concat(allocator, u8, &.{ ".", field.default_value.?.getSlice() }),
            else => null,
        };
    }

    fn getFieldTypeDescriptor(ctx: *Self, _: FullName, file: descriptor.FileDescriptorProto, field: descriptor.FieldDescriptorProto, is_union: bool) !string {
        _ = is_union;
        var prefix: string = "";

        var postfix: string = "";

        if (isRepeated(field)) {
            if (ctx.isPacked(file, field)) {
                prefix = ".{ .PackedList = ";
            } else {
                prefix = ".{ .List = ";
            }
            postfix = "}";
        }

        const infix: string = switch (field.type.?) {
            .TYPE_DOUBLE, .TYPE_SFIXED64, .TYPE_FIXED64 => ".{ .FixedInt = .I64 }",
            .TYPE_FLOAT, .TYPE_SFIXED32, .TYPE_FIXED32 => ".{ .FixedInt = .I32 }",
            .TYPE_ENUM, .TYPE_UINT32, .TYPE_UINT64, .TYPE_BOOL, .TYPE_INT32, .TYPE_INT64 => ".{ .Varint = .Simple }",
            .TYPE_SINT32, .TYPE_SINT64 => ".{ .Varint = .ZigZagOptimized }",
            .TYPE_STRING => ".String",
            .TYPE_BYTES => ".Bytes",
            .TYPE_MESSAGE => if (ctx.isBasicType(field) or isRepeated(field)) ".{ .SubMessage = {} }" else ".{ .AllocMessage = {} }",
            else => {
                std.debug.print("Unrecognized type {}\n", .{field.type.?});
                @panic("Unrecognized type");
            },
        };

        return try std.mem.concat(allocator, u8, &.{ prefix, infix, postfix });
    }

    fn generateFieldDescriptor(ctx: *Self, list: *std.ArrayList(string), fqn: FullName, file: descriptor.FileDescriptorProto, message: descriptor.DescriptorProto, field: descriptor.FieldDescriptorProto, is_union: bool) !void {
        _ = message;
        const name = try ctx.getFieldName(field);
        const descStr = try ctx.getFieldTypeDescriptor(fqn, file, field, is_union);
        const format = "        .{s} = fd({?d}, {s}),\n";
        try list.append(try std.fmt.allocPrint(allocator, format, .{ name, field.number, descStr }));
    }

    fn generateFieldDeclaration(ctx: *Self, list: *std.ArrayList(string), fqn: FullName, file: descriptor.FileDescriptorProto, message: descriptor.DescriptorProto, field: descriptor.FieldDescriptorProto, is_union: bool) !void {
        _ = message;

        const type_str = try ctx.getFieldType(fqn, file, field, is_union);
        const field_name = try ctx.getFieldName(field);

        const nullable = type_str[0] == '?';

        if (try ctx.getFieldDefault(field, file, nullable)) |default_value| {
            try list.append(try std.fmt.allocPrint(allocator, "    {s}: {s} = {s},\n", .{ field_name, type_str, default_value }));
        } else {
            try list.append(try std.fmt.allocPrint(allocator, "    {s}: {s},\n", .{ field_name, type_str }));
        }
    }

    /// this function returns the amount of options available for a given "oneof" declaration
    ///
    /// since protobuf 3.14, optional values in proto3 are wrapped in a single-element
    /// oneof to enable optional behavior in most languages. since we have optional types
    /// in zig, we can not use it for a better end-user experience and for readability
    fn amountOfElementsInOneofUnion(_: *Self, message: descriptor.DescriptorProto, oneof_index: ?i32) u32 {
        if (oneof_index == null) return 0;

        var count: u32 = 0;
        for (message.field.items) |f| {
            if (oneof_index == f.oneof_index)
                count += 1;
        }

        return count;
    }

    fn registerMessages(self: *Self, file: *const descriptor.FileDescriptorProto, prefix: *std.ArrayList(u8), messages: anytype) !void {
        const original_len = prefix.items.len;
        defer prefix.shrinkRetainingCapacity(original_len);

        try prefix.append('.');
        // for convenience this fn also handle a slice of enum descriptor.
        // but we need to handle recursion for messages.
        const is_msg = @hasField(std.meta.Elem(@TypeOf(messages)), "nested_type");

        for (messages) |*msg| {
            const last_len = prefix.items.len;
            defer prefix.shrinkRetainingCapacity(last_len);

            try prefix.appendSlice(msg.name.?.getSlice());
            var fqn = prefix.items;
            const res = try self.imports_map.getOrPut(fqn);
            if (res.found_existing) {
                const prev = res.value_ptr.*;
                std.debug.assert(std.mem.eql(u8, file.name.?.getSlice(), prev.file.name.?.getSlice()));
            } else {
                fqn = try allocator.dupe(u8, prefix.items);
                res.key_ptr.* = fqn;
                res.value_ptr.* = .{
                    .file = file,
                    .descriptor = if (is_msg) msg else null,
                };
            }

            if (is_msg) {
                try self.registerMessages(file, prefix, msg.nested_type.items);
                try self.registerMessages(file, prefix, msg.enum_type.items);
            }
        }
    }

    // fn resolveMessages(self: *Self, file: []const u8, messages: []const descriptor.DescriptorProto) !void {

    //     for (messages.items) |msg| {
    //         const res = self.basic_types.getOrPut(file);
    //         if (res.found_existing) {

    //         }
    //         const last_len = prefix.items.len;

    //         const res = try self.imports_map.getOrPut(fqn);
    //         if (res.found_existing) {
    //             std.debug.assert(std.mem.eql(u8, file, res.value_ptr.*));
    //         } else {
    //             res.key_ptr.* = fqn;
    //             res.value_ptr.* = file;
    //         }

    //         if (@hasField(@TypeOf(msg), "nested_type")) {
    //             try self.registerMessages(file, prefix, msg.nested_type);
    //         }
    //         if (@hasField(@TypeOf(msg), "enum_type")) {
    //             try self.registerMessages(file, prefix, msg.enum_type);
    //         }
    //     }
    // }

    fn generateMessages(ctx: *Self, list: *std.ArrayList(string), fqn: FullName, file: descriptor.FileDescriptorProto, messages: []const descriptor.DescriptorProto) !void {
        for (messages) |message| {
            const m: descriptor.DescriptorProto = message;
            const messageFqn = try fqn.append(allocator, m.name.?.getSlice());

            try list.append(try std.fmt.allocPrint(allocator, "\npub const {?} = struct {{\n", .{m.name}));

            // append all fields that are not part of a oneof
            for (m.field.items) |f| {
                if (f.oneof_index == null or ctx.amountOfElementsInOneofUnion(m, f.oneof_index) == 1) {
                    try ctx.generateFieldDeclaration(list, messageFqn, file, m, f, false);
                }
            }

            // print all oneof fields
            for (m.oneof_decl.items, 0..) |oneof, i| {
                const union_element_count = ctx.amountOfElementsInOneofUnion(m, @as(i32, @intCast(i)));
                if (union_element_count > 1) {
                    const oneof_name = oneof.name.?.getSlice();
                    try list.append(try std.fmt.allocPrint(allocator, "    {s}: ?union(enum) {{\n", .{try escapeName(oneof_name)}));

                    for (m.field.items) |field| {
                        const f: descriptor.FieldDescriptorProto = field;
                        if (f.oneof_index orelse -1 == @as(i32, @intCast(i))) {
                            const name = try ctx.getFieldName(f);
                            const typeStr = try ctx.getFieldType(messageFqn, file, f, true);
                            try list.append(try std.fmt.allocPrint(allocator, "      {?s}: {?s},\n", .{ name, typeStr }));
                        }
                    }

                    try list.append(
                        \\    pub const _union_desc = .{
                        \\
                    );

                    for (m.field.items) |field| {
                        const f: descriptor.FieldDescriptorProto = field;
                        if (f.oneof_index orelse -1 == @as(i32, @intCast(i))) {
                            try ctx.generateFieldDescriptor(list, messageFqn, file, m, f, true);
                        }
                    }

                    try list.append(
                        \\      };
                        \\    },
                        \\
                    );
                }
            }

            // field descriptors
            try list.append(
                \\
                \\    pub const _desc_table = .{
                \\
            );

            // first print fields
            for (m.field.items) |f| {
                if (f.oneof_index == null or ctx.amountOfElementsInOneofUnion(m, f.oneof_index) == 1) {
                    try ctx.generateFieldDescriptor(list, messageFqn, file, m, f, false);
                }
            }

            // print all oneof fields
            for (m.oneof_decl.items, 0..) |oneof, i| {
                // only emit unions that have more than one element
                const union_element_count = ctx.amountOfElementsInOneofUnion(m, @as(i32, @intCast(i)));
                if (union_element_count > 1) {
                    const oneof_name = oneof.name.?.getSlice();
                    try list.append(try std.fmt.allocPrint(allocator, "    .{s} = fd(null, .{{ .OneOf = std.meta.Child(std.meta.FieldType(@This(), .{s})) }}),\n", .{ oneof_name, oneof_name }));
                }
            }

            try list.append(
                \\    };
                \\
            );

            try ctx.generateEnums(list, messageFqn, file, m.enum_type.items);
            try ctx.generateMessages(list, messageFqn, file, m.nested_type.items);

            try list.append(try std.fmt.allocPrint(allocator,
                \\
                \\   pub const encode = protobuf.MessageMixins(@This()).encode;
                \\   pub const decode = protobuf.MessageMixins(@This()).decode;
                \\   pub const init = protobuf.MessageMixins(@This()).init;
                \\   pub const deinit = protobuf.MessageMixins(@This()).deinit;
                \\   pub const dupe = protobuf.MessageMixins(@This()).dupe;
                \\   pub const jsonStringify = protobuf.MessageMixins(@This()).jsonStringify;
                \\   pub const json_decode = protobuf.MessageMixins(@This()).json_decode;
                \\   pub const json_encode = protobuf.MessageMixins(@This()).json_encode;
                \\   pub const jsonParse = protobuf.MessageMixins(@This()).jsonParse;
                \\}};
                \\
            , .{}));
        }
    }
};

fn is_proto3_file(file: descriptor.FileDescriptorProto) bool {
    if (file.syntax) |syntax| return std.mem.eql(u8, syntax.getSlice(), "proto3");
    return false;
}

pub fn formatSliceEscapeImpl(
    str: string,
) !string {
    const charset = "0123456789ABCDEF";
    var buf: [4]u8 = undefined;

    var out = std.ArrayList(u8).init(allocator);
    defer out.deinit();
    var writer = out.writer();

    try writer.writeByte('"');

    buf[0] = '\\';
    buf[1] = 'x';

    for (str) |c| {
        if (c == '"') {
            try writer.writeByte('\\');
            try writer.writeByte('"');
        } else if (c == '\\') {
            try writer.writeByte('\\');
            try writer.writeByte('\\');
        } else if (std.ascii.isPrint(c)) {
            try writer.writeByte(c);
        } else {
            buf[2] = charset[c >> 4];
            buf[3] = charset[c & 15];
            try writer.writeAll(&buf);
        }
    }
    try writer.writeByte('"');
    return out.toOwnedSlice();
}

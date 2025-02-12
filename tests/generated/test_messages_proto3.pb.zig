// Code generated by protoc-gen-zig
///! package protobuf_test_messages.proto3
const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayListU = std.ArrayListUnmanaged;

const protobuf = @import("protobuf");
const ManagedString = protobuf.ManagedString;
const fd = protobuf.fd;

test {
    std.testing.refAllDeclsRecursive(@This());
}
/// import package google.protobuf
const google_protobuf_any_proto = @import("google/protobuf/any.pb.zig");
/// import package google.protobuf
const google_protobuf_duration_proto = @import("google/protobuf/duration.pb.zig");
/// import package google.protobuf
const google_protobuf_field_mask_proto = @import("google/protobuf/field_mask.pb.zig");
/// import package google.protobuf
const google_protobuf_struct_proto = @import("google/protobuf/struct.pb.zig");
/// import package google.protobuf
const google_protobuf_timestamp_proto = @import("google/protobuf/timestamp.pb.zig");
/// import package google.protobuf
const google_protobuf_wrappers_proto = @import("google/protobuf/wrappers.pb.zig");

pub const ForeignEnum = enum(i32) {
    FOREIGN_FOO = 0,
    FOREIGN_BAR = 1,
    FOREIGN_BAZ = 2,
    _,
};

pub const TestAllTypesProto3 = struct {
    optional_int32: i32 = 0,
    optional_int64: i64 = 0,
    optional_uint32: u32 = 0,
    optional_uint64: u64 = 0,
    optional_sint32: i32 = 0,
    optional_sint64: i64 = 0,
    optional_fixed32: u32 = 0,
    optional_fixed64: u64 = 0,
    optional_sfixed32: i32 = 0,
    optional_sfixed64: i64 = 0,
    optional_float: f32 = 0,
    optional_double: f64 = 0,
    optional_bool: bool = false,
    optional_string: ManagedString = .Empty,
    optional_bytes: ManagedString = .Empty,
    optional_nested_message: ?TestAllTypesProto3.NestedMessage = null,
    optional_foreign_message: ?ForeignMessage = null,
    optional_nested_enum: TestAllTypesProto3.NestedEnum = @enumFromInt(0),
    optional_foreign_enum: ForeignEnum = @enumFromInt(0),
    optional_aliased_enum: TestAllTypesProto3.AliasedEnum = @enumFromInt(0),
    optional_string_piece: ManagedString = .Empty,
    optional_cord: ManagedString = .Empty,
    repeated_int32: ArrayListU(i32) = .{},
    repeated_int64: ArrayListU(i64) = .{},
    repeated_uint32: ArrayListU(u32) = .{},
    repeated_uint64: ArrayListU(u64) = .{},
    repeated_sint32: ArrayListU(i32) = .{},
    repeated_sint64: ArrayListU(i64) = .{},
    repeated_fixed32: ArrayListU(u32) = .{},
    repeated_fixed64: ArrayListU(u64) = .{},
    repeated_sfixed32: ArrayListU(i32) = .{},
    repeated_sfixed64: ArrayListU(i64) = .{},
    repeated_float: ArrayListU(f32) = .{},
    repeated_double: ArrayListU(f64) = .{},
    repeated_bool: ArrayListU(bool) = .{},
    repeated_string: ArrayListU(ManagedString) = .{},
    repeated_bytes: ArrayListU(ManagedString) = .{},
    repeated_nested_message: ArrayListU(TestAllTypesProto3.NestedMessage) = .{},
    repeated_foreign_message: ArrayListU(ForeignMessage) = .{},
    repeated_nested_enum: ArrayListU(TestAllTypesProto3.NestedEnum) = .{},
    repeated_foreign_enum: ArrayListU(ForeignEnum) = .{},
    repeated_string_piece: ArrayListU(ManagedString) = .{},
    repeated_cord: ArrayListU(ManagedString) = .{},
    packed_int32: ArrayListU(i32) = .{},
    packed_int64: ArrayListU(i64) = .{},
    packed_uint32: ArrayListU(u32) = .{},
    packed_uint64: ArrayListU(u64) = .{},
    packed_sint32: ArrayListU(i32) = .{},
    packed_sint64: ArrayListU(i64) = .{},
    packed_fixed32: ArrayListU(u32) = .{},
    packed_fixed64: ArrayListU(u64) = .{},
    packed_sfixed32: ArrayListU(i32) = .{},
    packed_sfixed64: ArrayListU(i64) = .{},
    packed_float: ArrayListU(f32) = .{},
    packed_double: ArrayListU(f64) = .{},
    packed_bool: ArrayListU(bool) = .{},
    packed_nested_enum: ArrayListU(TestAllTypesProto3.NestedEnum) = .{},
    unpacked_int32: ArrayListU(i32) = .{},
    unpacked_int64: ArrayListU(i64) = .{},
    unpacked_uint32: ArrayListU(u32) = .{},
    unpacked_uint64: ArrayListU(u64) = .{},
    unpacked_sint32: ArrayListU(i32) = .{},
    unpacked_sint64: ArrayListU(i64) = .{},
    unpacked_fixed32: ArrayListU(u32) = .{},
    unpacked_fixed64: ArrayListU(u64) = .{},
    unpacked_sfixed32: ArrayListU(i32) = .{},
    unpacked_sfixed64: ArrayListU(i64) = .{},
    unpacked_float: ArrayListU(f32) = .{},
    unpacked_double: ArrayListU(f64) = .{},
    unpacked_bool: ArrayListU(bool) = .{},
    unpacked_nested_enum: ArrayListU(TestAllTypesProto3.NestedEnum) = .{},
    map_int32_int32: ArrayListU(TestAllTypesProto3.MapInt32Int32Entry) = .{},
    map_int64_int64: ArrayListU(TestAllTypesProto3.MapInt64Int64Entry) = .{},
    map_uint32_uint32: ArrayListU(TestAllTypesProto3.MapUint32Uint32Entry) = .{},
    map_uint64_uint64: ArrayListU(TestAllTypesProto3.MapUint64Uint64Entry) = .{},
    map_sint32_sint32: ArrayListU(TestAllTypesProto3.MapSint32Sint32Entry) = .{},
    map_sint64_sint64: ArrayListU(TestAllTypesProto3.MapSint64Sint64Entry) = .{},
    map_fixed32_fixed32: ArrayListU(TestAllTypesProto3.MapFixed32Fixed32Entry) = .{},
    map_fixed64_fixed64: ArrayListU(TestAllTypesProto3.MapFixed64Fixed64Entry) = .{},
    map_sfixed32_sfixed32: ArrayListU(TestAllTypesProto3.MapSfixed32Sfixed32Entry) = .{},
    map_sfixed64_sfixed64: ArrayListU(TestAllTypesProto3.MapSfixed64Sfixed64Entry) = .{},
    map_int32_float: ArrayListU(TestAllTypesProto3.MapInt32FloatEntry) = .{},
    map_int32_double: ArrayListU(TestAllTypesProto3.MapInt32DoubleEntry) = .{},
    map_bool_bool: ArrayListU(TestAllTypesProto3.MapBoolBoolEntry) = .{},
    map_string_string: ArrayListU(TestAllTypesProto3.MapStringStringEntry) = .{},
    map_string_bytes: ArrayListU(TestAllTypesProto3.MapStringBytesEntry) = .{},
    map_string_nested_message: ArrayListU(TestAllTypesProto3.MapStringNestedMessageEntry) = .{},
    map_string_foreign_message: ArrayListU(TestAllTypesProto3.MapStringForeignMessageEntry) = .{},
    map_string_nested_enum: ArrayListU(TestAllTypesProto3.MapStringNestedEnumEntry) = .{},
    map_string_foreign_enum: ArrayListU(TestAllTypesProto3.MapStringForeignEnumEntry) = .{},
    optional_bool_wrapper: ?google_protobuf_wrappers_proto.BoolValue = null,
    optional_int32_wrapper: ?google_protobuf_wrappers_proto.Int32Value = null,
    optional_int64_wrapper: ?google_protobuf_wrappers_proto.Int64Value = null,
    optional_uint32_wrapper: ?google_protobuf_wrappers_proto.UInt32Value = null,
    optional_uint64_wrapper: ?google_protobuf_wrappers_proto.UInt64Value = null,
    optional_float_wrapper: ?google_protobuf_wrappers_proto.FloatValue = null,
    optional_double_wrapper: ?google_protobuf_wrappers_proto.DoubleValue = null,
    optional_string_wrapper: ?google_protobuf_wrappers_proto.StringValue = null,
    optional_bytes_wrapper: ?google_protobuf_wrappers_proto.BytesValue = null,
    repeated_bool_wrapper: ArrayListU(google_protobuf_wrappers_proto.BoolValue) = .{},
    repeated_int32_wrapper: ArrayListU(google_protobuf_wrappers_proto.Int32Value) = .{},
    repeated_int64_wrapper: ArrayListU(google_protobuf_wrappers_proto.Int64Value) = .{},
    repeated_uint32_wrapper: ArrayListU(google_protobuf_wrappers_proto.UInt32Value) = .{},
    repeated_uint64_wrapper: ArrayListU(google_protobuf_wrappers_proto.UInt64Value) = .{},
    repeated_float_wrapper: ArrayListU(google_protobuf_wrappers_proto.FloatValue) = .{},
    repeated_double_wrapper: ArrayListU(google_protobuf_wrappers_proto.DoubleValue) = .{},
    repeated_string_wrapper: ArrayListU(google_protobuf_wrappers_proto.StringValue) = .{},
    repeated_bytes_wrapper: ArrayListU(google_protobuf_wrappers_proto.BytesValue) = .{},
    optional_duration: ?google_protobuf_duration_proto.Duration = null,
    optional_timestamp: ?google_protobuf_timestamp_proto.Timestamp = null,
    optional_field_mask: ?google_protobuf_field_mask_proto.FieldMask = null,
    optional_struct: ?google_protobuf_struct_proto.Struct = null,
    optional_any: ?google_protobuf_any_proto.Any = null,
    optional_value: ?*const google_protobuf_struct_proto.Value = null,
    optional_null_value: google_protobuf_struct_proto.NullValue = @enumFromInt(0),
    repeated_duration: ArrayListU(google_protobuf_duration_proto.Duration) = .{},
    repeated_timestamp: ArrayListU(google_protobuf_timestamp_proto.Timestamp) = .{},
    repeated_fieldmask: ArrayListU(google_protobuf_field_mask_proto.FieldMask) = .{},
    repeated_struct: ArrayListU(google_protobuf_struct_proto.Struct) = .{},
    repeated_any: ArrayListU(google_protobuf_any_proto.Any) = .{},
    repeated_value: ArrayListU(google_protobuf_struct_proto.Value) = .{},
    repeated_list_value: ArrayListU(google_protobuf_struct_proto.ListValue) = .{},
    fieldname1: i32 = 0,
    field_name2: i32 = 0,
    _field_name3: i32 = 0,
    field__name4_: i32 = 0,
    field0name5: i32 = 0,
    field_0_name6: i32 = 0,
    fieldName7: i32 = 0,
    FieldName8: i32 = 0,
    field_Name9: i32 = 0,
    Field_Name10: i32 = 0,
    FIELD_NAME11: i32 = 0,
    FIELD_name12: i32 = 0,
    __field_name13: i32 = 0,
    __Field_name14: i32 = 0,
    field__name15: i32 = 0,
    field__Name16: i32 = 0,
    field_name17__: i32 = 0,
    Field_name18__: i32 = 0,
    oneof_field: ?union(enum) {
        oneof_uint32: u32,
        oneof_nested_message: TestAllTypesProto3.NestedMessage,
        oneof_string: ManagedString,
        oneof_bytes: ManagedString,
        oneof_bool: bool,
        oneof_uint64: u64,
        oneof_float: f32,
        oneof_double: f64,
        oneof_enum: TestAllTypesProto3.NestedEnum,
        oneof_null_value: google_protobuf_struct_proto.NullValue,
        pub const _union_desc = .{
            .oneof_uint32 = fd(111, .{ .Varint = .Simple }),
            .oneof_nested_message = fd(112, .{ .SubMessage = {} }),
            .oneof_string = fd(113, .String),
            .oneof_bytes = fd(114, .Bytes),
            .oneof_bool = fd(115, .{ .Varint = .Simple }),
            .oneof_uint64 = fd(116, .{ .Varint = .Simple }),
            .oneof_float = fd(117, .{ .FixedInt = .I32 }),
            .oneof_double = fd(118, .{ .FixedInt = .I64 }),
            .oneof_enum = fd(119, .{ .Varint = .Simple }),
            .oneof_null_value = fd(120, .{ .Varint = .Simple }),
        };
    },

    pub const _desc_table = .{
        .optional_int32 = fd(1, .{ .Varint = .Simple }),
        .optional_int64 = fd(2, .{ .Varint = .Simple }),
        .optional_uint32 = fd(3, .{ .Varint = .Simple }),
        .optional_uint64 = fd(4, .{ .Varint = .Simple }),
        .optional_sint32 = fd(5, .{ .Varint = .ZigZagOptimized }),
        .optional_sint64 = fd(6, .{ .Varint = .ZigZagOptimized }),
        .optional_fixed32 = fd(7, .{ .FixedInt = .I32 }),
        .optional_fixed64 = fd(8, .{ .FixedInt = .I64 }),
        .optional_sfixed32 = fd(9, .{ .FixedInt = .I32 }),
        .optional_sfixed64 = fd(10, .{ .FixedInt = .I64 }),
        .optional_float = fd(11, .{ .FixedInt = .I32 }),
        .optional_double = fd(12, .{ .FixedInt = .I64 }),
        .optional_bool = fd(13, .{ .Varint = .Simple }),
        .optional_string = fd(14, .String),
        .optional_bytes = fd(15, .Bytes),
        .optional_nested_message = fd(18, .{ .SubMessage = {} }),
        .optional_foreign_message = fd(19, .{ .SubMessage = {} }),
        .optional_nested_enum = fd(21, .{ .Varint = .Simple }),
        .optional_foreign_enum = fd(22, .{ .Varint = .Simple }),
        .optional_aliased_enum = fd(23, .{ .Varint = .Simple }),
        .optional_string_piece = fd(24, .String),
        .optional_cord = fd(25, .String),
        .repeated_int32 = fd(31, .{ .PackedList = .{ .Varint = .Simple } }),
        .repeated_int64 = fd(32, .{ .PackedList = .{ .Varint = .Simple } }),
        .repeated_uint32 = fd(33, .{ .PackedList = .{ .Varint = .Simple } }),
        .repeated_uint64 = fd(34, .{ .PackedList = .{ .Varint = .Simple } }),
        .repeated_sint32 = fd(35, .{ .PackedList = .{ .Varint = .ZigZagOptimized } }),
        .repeated_sint64 = fd(36, .{ .PackedList = .{ .Varint = .ZigZagOptimized } }),
        .repeated_fixed32 = fd(37, .{ .PackedList = .{ .FixedInt = .I32 } }),
        .repeated_fixed64 = fd(38, .{ .PackedList = .{ .FixedInt = .I64 } }),
        .repeated_sfixed32 = fd(39, .{ .PackedList = .{ .FixedInt = .I32 } }),
        .repeated_sfixed64 = fd(40, .{ .PackedList = .{ .FixedInt = .I64 } }),
        .repeated_float = fd(41, .{ .PackedList = .{ .FixedInt = .I32 } }),
        .repeated_double = fd(42, .{ .PackedList = .{ .FixedInt = .I64 } }),
        .repeated_bool = fd(43, .{ .PackedList = .{ .Varint = .Simple } }),
        .repeated_string = fd(44, .{ .List = .String }),
        .repeated_bytes = fd(45, .{ .List = .Bytes }),
        .repeated_nested_message = fd(48, .{ .List = .{ .SubMessage = {} } }),
        .repeated_foreign_message = fd(49, .{ .List = .{ .SubMessage = {} } }),
        .repeated_nested_enum = fd(51, .{ .List = .{ .Varint = .Simple } }),
        .repeated_foreign_enum = fd(52, .{ .List = .{ .Varint = .Simple } }),
        .repeated_string_piece = fd(54, .{ .List = .String }),
        .repeated_cord = fd(55, .{ .List = .String }),
        .packed_int32 = fd(75, .{ .PackedList = .{ .Varint = .Simple } }),
        .packed_int64 = fd(76, .{ .PackedList = .{ .Varint = .Simple } }),
        .packed_uint32 = fd(77, .{ .PackedList = .{ .Varint = .Simple } }),
        .packed_uint64 = fd(78, .{ .PackedList = .{ .Varint = .Simple } }),
        .packed_sint32 = fd(79, .{ .PackedList = .{ .Varint = .ZigZagOptimized } }),
        .packed_sint64 = fd(80, .{ .PackedList = .{ .Varint = .ZigZagOptimized } }),
        .packed_fixed32 = fd(81, .{ .PackedList = .{ .FixedInt = .I32 } }),
        .packed_fixed64 = fd(82, .{ .PackedList = .{ .FixedInt = .I64 } }),
        .packed_sfixed32 = fd(83, .{ .PackedList = .{ .FixedInt = .I32 } }),
        .packed_sfixed64 = fd(84, .{ .PackedList = .{ .FixedInt = .I64 } }),
        .packed_float = fd(85, .{ .PackedList = .{ .FixedInt = .I32 } }),
        .packed_double = fd(86, .{ .PackedList = .{ .FixedInt = .I64 } }),
        .packed_bool = fd(87, .{ .PackedList = .{ .Varint = .Simple } }),
        .packed_nested_enum = fd(88, .{ .PackedList = .{ .Varint = .Simple } }),
        .unpacked_int32 = fd(89, .{ .List = .{ .Varint = .Simple } }),
        .unpacked_int64 = fd(90, .{ .List = .{ .Varint = .Simple } }),
        .unpacked_uint32 = fd(91, .{ .List = .{ .Varint = .Simple } }),
        .unpacked_uint64 = fd(92, .{ .List = .{ .Varint = .Simple } }),
        .unpacked_sint32 = fd(93, .{ .List = .{ .Varint = .ZigZagOptimized } }),
        .unpacked_sint64 = fd(94, .{ .List = .{ .Varint = .ZigZagOptimized } }),
        .unpacked_fixed32 = fd(95, .{ .List = .{ .FixedInt = .I32 } }),
        .unpacked_fixed64 = fd(96, .{ .List = .{ .FixedInt = .I64 } }),
        .unpacked_sfixed32 = fd(97, .{ .List = .{ .FixedInt = .I32 } }),
        .unpacked_sfixed64 = fd(98, .{ .List = .{ .FixedInt = .I64 } }),
        .unpacked_float = fd(99, .{ .List = .{ .FixedInt = .I32 } }),
        .unpacked_double = fd(100, .{ .List = .{ .FixedInt = .I64 } }),
        .unpacked_bool = fd(101, .{ .List = .{ .Varint = .Simple } }),
        .unpacked_nested_enum = fd(102, .{ .List = .{ .Varint = .Simple } }),
        .map_int32_int32 = fd(56, .{ .List = .{ .SubMessage = {} } }),
        .map_int64_int64 = fd(57, .{ .List = .{ .SubMessage = {} } }),
        .map_uint32_uint32 = fd(58, .{ .List = .{ .SubMessage = {} } }),
        .map_uint64_uint64 = fd(59, .{ .List = .{ .SubMessage = {} } }),
        .map_sint32_sint32 = fd(60, .{ .List = .{ .SubMessage = {} } }),
        .map_sint64_sint64 = fd(61, .{ .List = .{ .SubMessage = {} } }),
        .map_fixed32_fixed32 = fd(62, .{ .List = .{ .SubMessage = {} } }),
        .map_fixed64_fixed64 = fd(63, .{ .List = .{ .SubMessage = {} } }),
        .map_sfixed32_sfixed32 = fd(64, .{ .List = .{ .SubMessage = {} } }),
        .map_sfixed64_sfixed64 = fd(65, .{ .List = .{ .SubMessage = {} } }),
        .map_int32_float = fd(66, .{ .List = .{ .SubMessage = {} } }),
        .map_int32_double = fd(67, .{ .List = .{ .SubMessage = {} } }),
        .map_bool_bool = fd(68, .{ .List = .{ .SubMessage = {} } }),
        .map_string_string = fd(69, .{ .List = .{ .SubMessage = {} } }),
        .map_string_bytes = fd(70, .{ .List = .{ .SubMessage = {} } }),
        .map_string_nested_message = fd(71, .{ .List = .{ .SubMessage = {} } }),
        .map_string_foreign_message = fd(72, .{ .List = .{ .SubMessage = {} } }),
        .map_string_nested_enum = fd(73, .{ .List = .{ .SubMessage = {} } }),
        .map_string_foreign_enum = fd(74, .{ .List = .{ .SubMessage = {} } }),
        .optional_bool_wrapper = fd(201, .{ .SubMessage = {} }),
        .optional_int32_wrapper = fd(202, .{ .SubMessage = {} }),
        .optional_int64_wrapper = fd(203, .{ .SubMessage = {} }),
        .optional_uint32_wrapper = fd(204, .{ .SubMessage = {} }),
        .optional_uint64_wrapper = fd(205, .{ .SubMessage = {} }),
        .optional_float_wrapper = fd(206, .{ .SubMessage = {} }),
        .optional_double_wrapper = fd(207, .{ .SubMessage = {} }),
        .optional_string_wrapper = fd(208, .{ .SubMessage = {} }),
        .optional_bytes_wrapper = fd(209, .{ .SubMessage = {} }),
        .repeated_bool_wrapper = fd(211, .{ .List = .{ .SubMessage = {} } }),
        .repeated_int32_wrapper = fd(212, .{ .List = .{ .SubMessage = {} } }),
        .repeated_int64_wrapper = fd(213, .{ .List = .{ .SubMessage = {} } }),
        .repeated_uint32_wrapper = fd(214, .{ .List = .{ .SubMessage = {} } }),
        .repeated_uint64_wrapper = fd(215, .{ .List = .{ .SubMessage = {} } }),
        .repeated_float_wrapper = fd(216, .{ .List = .{ .SubMessage = {} } }),
        .repeated_double_wrapper = fd(217, .{ .List = .{ .SubMessage = {} } }),
        .repeated_string_wrapper = fd(218, .{ .List = .{ .SubMessage = {} } }),
        .repeated_bytes_wrapper = fd(219, .{ .List = .{ .SubMessage = {} } }),
        .optional_duration = fd(301, .{ .SubMessage = {} }),
        .optional_timestamp = fd(302, .{ .SubMessage = {} }),
        .optional_field_mask = fd(303, .{ .SubMessage = {} }),
        .optional_struct = fd(304, .{ .SubMessage = {} }),
        .optional_any = fd(305, .{ .SubMessage = {} }),
        .optional_value = fd(306, .{ .AllocMessage = {} }),
        .optional_null_value = fd(307, .{ .Varint = .Simple }),
        .repeated_duration = fd(311, .{ .List = .{ .SubMessage = {} } }),
        .repeated_timestamp = fd(312, .{ .List = .{ .SubMessage = {} } }),
        .repeated_fieldmask = fd(313, .{ .List = .{ .SubMessage = {} } }),
        .repeated_struct = fd(324, .{ .List = .{ .SubMessage = {} } }),
        .repeated_any = fd(315, .{ .List = .{ .SubMessage = {} } }),
        .repeated_value = fd(316, .{ .List = .{ .SubMessage = {} } }),
        .repeated_list_value = fd(317, .{ .List = .{ .SubMessage = {} } }),
        .fieldname1 = fd(401, .{ .Varint = .Simple }),
        .field_name2 = fd(402, .{ .Varint = .Simple }),
        ._field_name3 = fd(403, .{ .Varint = .Simple }),
        .field__name4_ = fd(404, .{ .Varint = .Simple }),
        .field0name5 = fd(405, .{ .Varint = .Simple }),
        .field_0_name6 = fd(406, .{ .Varint = .Simple }),
        .fieldName7 = fd(407, .{ .Varint = .Simple }),
        .FieldName8 = fd(408, .{ .Varint = .Simple }),
        .field_Name9 = fd(409, .{ .Varint = .Simple }),
        .Field_Name10 = fd(410, .{ .Varint = .Simple }),
        .FIELD_NAME11 = fd(411, .{ .Varint = .Simple }),
        .FIELD_name12 = fd(412, .{ .Varint = .Simple }),
        .__field_name13 = fd(413, .{ .Varint = .Simple }),
        .__Field_name14 = fd(414, .{ .Varint = .Simple }),
        .field__name15 = fd(415, .{ .Varint = .Simple }),
        .field__Name16 = fd(416, .{ .Varint = .Simple }),
        .field_name17__ = fd(417, .{ .Varint = .Simple }),
        .Field_name18__ = fd(418, .{ .Varint = .Simple }),
        .oneof_field = fd(null, .{ .OneOf = std.meta.Child(std.meta.FieldType(@This(), .oneof_field)) }),
    };

    pub const NestedEnum = enum(i32) {
        FOO = 0,
        BAR = 1,
        BAZ = 2,
        NEG = -1,
        _,
    };

    pub const AliasedEnum = enum(i32) {
        ALIAS_FOO = 0,
        ALIAS_BAR = 1,
        MOO = 2,
        _,
    };

    pub const NestedMessage = struct {
        a: i32 = 0,

        pub const _desc_table = .{
            .a = fd(1, .{ .Varint = .Simple }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapInt32Int32Entry = struct {
        key: i32 = 0,
        value: i32 = 0,

        pub const _desc_table = .{
            .key = fd(1, .{ .Varint = .Simple }),
            .value = fd(2, .{ .Varint = .Simple }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapInt64Int64Entry = struct {
        key: i64 = 0,
        value: i64 = 0,

        pub const _desc_table = .{
            .key = fd(1, .{ .Varint = .Simple }),
            .value = fd(2, .{ .Varint = .Simple }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapUint32Uint32Entry = struct {
        key: u32 = 0,
        value: u32 = 0,

        pub const _desc_table = .{
            .key = fd(1, .{ .Varint = .Simple }),
            .value = fd(2, .{ .Varint = .Simple }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapUint64Uint64Entry = struct {
        key: u64 = 0,
        value: u64 = 0,

        pub const _desc_table = .{
            .key = fd(1, .{ .Varint = .Simple }),
            .value = fd(2, .{ .Varint = .Simple }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapSint32Sint32Entry = struct {
        key: i32 = 0,
        value: i32 = 0,

        pub const _desc_table = .{
            .key = fd(1, .{ .Varint = .ZigZagOptimized }),
            .value = fd(2, .{ .Varint = .ZigZagOptimized }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapSint64Sint64Entry = struct {
        key: i64 = 0,
        value: i64 = 0,

        pub const _desc_table = .{
            .key = fd(1, .{ .Varint = .ZigZagOptimized }),
            .value = fd(2, .{ .Varint = .ZigZagOptimized }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapFixed32Fixed32Entry = struct {
        key: u32 = 0,
        value: u32 = 0,

        pub const _desc_table = .{
            .key = fd(1, .{ .FixedInt = .I32 }),
            .value = fd(2, .{ .FixedInt = .I32 }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapFixed64Fixed64Entry = struct {
        key: u64 = 0,
        value: u64 = 0,

        pub const _desc_table = .{
            .key = fd(1, .{ .FixedInt = .I64 }),
            .value = fd(2, .{ .FixedInt = .I64 }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapSfixed32Sfixed32Entry = struct {
        key: i32 = 0,
        value: i32 = 0,

        pub const _desc_table = .{
            .key = fd(1, .{ .FixedInt = .I32 }),
            .value = fd(2, .{ .FixedInt = .I32 }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapSfixed64Sfixed64Entry = struct {
        key: i64 = 0,
        value: i64 = 0,

        pub const _desc_table = .{
            .key = fd(1, .{ .FixedInt = .I64 }),
            .value = fd(2, .{ .FixedInt = .I64 }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapInt32FloatEntry = struct {
        key: i32 = 0,
        value: f32 = 0,

        pub const _desc_table = .{
            .key = fd(1, .{ .Varint = .Simple }),
            .value = fd(2, .{ .FixedInt = .I32 }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapInt32DoubleEntry = struct {
        key: i32 = 0,
        value: f64 = 0,

        pub const _desc_table = .{
            .key = fd(1, .{ .Varint = .Simple }),
            .value = fd(2, .{ .FixedInt = .I64 }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapBoolBoolEntry = struct {
        key: bool = false,
        value: bool = false,

        pub const _desc_table = .{
            .key = fd(1, .{ .Varint = .Simple }),
            .value = fd(2, .{ .Varint = .Simple }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapStringStringEntry = struct {
        key: ManagedString = .Empty,
        value: ManagedString = .Empty,

        pub const _desc_table = .{
            .key = fd(1, .String),
            .value = fd(2, .String),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapStringBytesEntry = struct {
        key: ManagedString = .Empty,
        value: ManagedString = .Empty,

        pub const _desc_table = .{
            .key = fd(1, .String),
            .value = fd(2, .Bytes),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapStringNestedMessageEntry = struct {
        key: ManagedString = .Empty,
        value: ?TestAllTypesProto3.NestedMessage = null,

        pub const _desc_table = .{
            .key = fd(1, .String),
            .value = fd(2, .{ .SubMessage = {} }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapStringForeignMessageEntry = struct {
        key: ManagedString = .Empty,
        value: ?ForeignMessage = null,

        pub const _desc_table = .{
            .key = fd(1, .String),
            .value = fd(2, .{ .SubMessage = {} }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapStringNestedEnumEntry = struct {
        key: ManagedString = .Empty,
        value: TestAllTypesProto3.NestedEnum = @enumFromInt(0),

        pub const _desc_table = .{
            .key = fd(1, .String),
            .value = fd(2, .{ .Varint = .Simple }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapStringForeignEnumEntry = struct {
        key: ManagedString = .Empty,
        value: ForeignEnum = @enumFromInt(0),

        pub const _desc_table = .{
            .key = fd(1, .String),
            .value = fd(2, .{ .Varint = .Simple }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const ForeignMessage = struct {
    c: i32 = 0,

    pub const _desc_table = .{
        .c = fd(1, .{ .Varint = .Simple }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const NullHypothesisProto3 = struct {
    pub const _desc_table = .{};

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const EnumOnlyProto3 = struct {
    pub const _desc_table = .{};

    pub const Bool = enum(i32) {
        kFalse = 0,
        kTrue = 1,
        _,
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

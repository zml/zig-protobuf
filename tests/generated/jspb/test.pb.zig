// Code generated by protoc-gen-zig
///! package jspb.test
const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

const protobuf = @import("protobuf");
const ManagedString = protobuf.ManagedString;
const fd = protobuf.fd;
/// import package google.protobuf
const google_protobuf = @import("../google/protobuf.pb.zig");

pub const OuterEnum = enum(i32) {
    FOO = 1,
    BAR = 2,
    _,
};

pub const MapValueEnumNoBinary = enum(i32) {
    MAP_VALUE_FOO_NOBINARY = 0,
    MAP_VALUE_BAR_NOBINARY = 1,
    MAP_VALUE_BAZ_NOBINARY = 2,
    _,
};

pub const Empty = struct {
    pub const _desc_table = .{};

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const EnumContainer = struct {
    outer_enum: ?OuterEnum = null,

    pub const _desc_table = .{
        .outer_enum = fd(1, .{ .Varint = .Simple }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Simple1 = struct {
    a_string: ManagedString,
    a_repeated_string: ArrayList(ManagedString),
    a_boolean: ?bool = null,

    pub const _desc_table = .{
        .a_string = fd(1, .String),
        .a_repeated_string = fd(2, .{ .List = .String }),
        .a_boolean = fd(3, .{ .Varint = .Simple }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Simple2 = struct {
    a_string: ManagedString,
    a_repeated_string: ArrayList(ManagedString),

    pub const _desc_table = .{
        .a_string = fd(1, .String),
        .a_repeated_string = fd(2, .{ .List = .String }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const SpecialCases = struct {
    normal: ManagedString,
    default: ManagedString,
    function: ManagedString,
    @"var": ManagedString,

    pub const _desc_table = .{
        .normal = fd(1, .String),
        .default = fd(2, .String),
        .function = fd(3, .String),
        .@"var" = fd(4, .String),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const OptionalFields = struct {
    a_string: ?ManagedString = null,
    a_bool: bool,
    a_nested_message: ?Nested = null,
    a_repeated_message: ArrayList(Nested),
    a_repeated_string: ArrayList(ManagedString),

    pub const _desc_table = .{
        .a_string = fd(1, .String),
        .a_bool = fd(2, .{ .Varint = .Simple }),
        .a_nested_message = fd(3, .{ .SubMessage = {} }),
        .a_repeated_message = fd(4, .{ .List = .{ .SubMessage = {} } }),
        .a_repeated_string = fd(5, .{ .List = .String }),
    };

    pub const Nested = struct {
        an_int: ?i32 = null,

        pub const _desc_table = .{
            .an_int = fd(1, .{ .Varint = .Simple }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const HasExtensions = struct {
    str1: ?ManagedString = null,
    str2: ?ManagedString = null,
    str3: ?ManagedString = null,

    pub const _desc_table = .{
        .str1 = fd(1, .String),
        .str2 = fd(2, .String),
        .str3 = fd(3, .String),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Complex = struct {
    a_string: ManagedString,
    an_out_of_order_bool: bool,
    a_nested_message: ?Nested = null,
    a_repeated_message: ArrayList(Nested),
    a_repeated_string: ArrayList(ManagedString),

    pub const _desc_table = .{
        .a_string = fd(1, .String),
        .an_out_of_order_bool = fd(9, .{ .Varint = .Simple }),
        .a_nested_message = fd(4, .{ .SubMessage = {} }),
        .a_repeated_message = fd(5, .{ .List = .{ .SubMessage = {} } }),
        .a_repeated_string = fd(7, .{ .List = .String }),
    };

    pub const Nested = struct {
        an_int: i32,

        pub const _desc_table = .{
            .an_int = fd(2, .{ .Varint = .Simple }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const IsExtension = struct {
    ext1: ?ManagedString = null,

    pub const _desc_table = .{
        .ext1 = fd(1, .String),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const IndirectExtension = struct {
    pub const _desc_table = .{};

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const DefaultValues = struct {
    string_field: ?ManagedString = ManagedString.static("default<>'\"abc"),
    bool_field: ?bool = true,
    int_field: ?i64 = 11,
    enum_field: ?Enum = .E1,
    empty_field: ?ManagedString = .Empty,
    bytes_field: ?ManagedString = ManagedString.static("moo"),

    pub const _desc_table = .{
        .string_field = fd(1, .String),
        .bool_field = fd(2, .{ .Varint = .Simple }),
        .int_field = fd(3, .{ .Varint = .Simple }),
        .enum_field = fd(4, .{ .Varint = .Simple }),
        .empty_field = fd(6, .String),
        .bytes_field = fd(8, .String),
    };

    pub const Enum = enum(i32) {
        E1 = 13,
        E2 = 77,
        _,
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const FloatingPointFields = struct {
    optional_float_field: ?f32 = null,
    required_float_field: f32,
    repeated_float_field: ArrayList(f32),
    default_float_field: ?f32 = 2,
    optional_double_field: ?f64 = null,
    required_double_field: f64,
    repeated_double_field: ArrayList(f64),
    default_double_field: ?f64 = 2,

    pub const _desc_table = .{
        .optional_float_field = fd(1, .{ .FixedInt = .I32 }),
        .required_float_field = fd(2, .{ .FixedInt = .I32 }),
        .repeated_float_field = fd(3, .{ .List = .{ .FixedInt = .I32 } }),
        .default_float_field = fd(4, .{ .FixedInt = .I32 }),
        .optional_double_field = fd(5, .{ .FixedInt = .I64 }),
        .required_double_field = fd(6, .{ .FixedInt = .I64 }),
        .repeated_double_field = fd(7, .{ .List = .{ .FixedInt = .I64 } }),
        .default_double_field = fd(8, .{ .FixedInt = .I64 }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const TestClone = struct {
    str: ?ManagedString = null,
    simple1: ?Simple1 = null,
    simple2: ArrayList(Simple1),
    bytes_field: ?ManagedString = null,
    unused: ?ManagedString = null,

    pub const _desc_table = .{
        .str = fd(1, .String),
        .simple1 = fd(3, .{ .SubMessage = {} }),
        .simple2 = fd(5, .{ .List = .{ .SubMessage = {} } }),
        .bytes_field = fd(6, .String),
        .unused = fd(7, .String),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const CloneExtension = struct {
    ext: ?ManagedString = null,

    pub const _desc_table = .{
        .ext = fd(2, .String),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const TestGroup = struct {
    id: ?ManagedString = null,
    required_simple: ?Simple2 = null,
    optional_simple: ?Simple2 = null,

    pub const _desc_table = .{
        .id = fd(6, .String),
        .required_simple = fd(7, .{ .SubMessage = {} }),
        .optional_simple = fd(8, .{ .SubMessage = {} }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const TestReservedNames = struct {
    extension: ?i32 = null,

    pub const _desc_table = .{
        .extension = fd(1, .{ .Varint = .Simple }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const TestReservedNamesExtension = struct {
    pub const _desc_table = .{};

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const TestMessageWithOneof = struct {
    normal_field: ?bool = null,
    repeated_field: ArrayList(ManagedString),
    partial_oneof: ?union(enum) {
        pone: ManagedString,
        pthree: ManagedString,
        pub const _union_desc = .{
            .pone = fd(3, .String),
            .pthree = fd(5, .String),
        };
    },
    recursive_oneof: ?union(enum) {
        rone: TestMessageWithOneof,
        rtwo: ManagedString,
        pub const _union_desc = .{
            .rone = fd(6, .{ .SubMessage = {} }),
            .rtwo = fd(7, .String),
        };
    },
    default_oneof_a: ?union(enum) {
        aone: i32,
        atwo: i32,
        pub const _union_desc = .{
            .aone = fd(10, .{ .Varint = .Simple }),
            .atwo = fd(11, .{ .Varint = .Simple }),
        };
    },
    default_oneof_b: ?union(enum) {
        bone: i32,
        btwo: i32,
        pub const _union_desc = .{
            .bone = fd(12, .{ .Varint = .Simple }),
            .btwo = fd(13, .{ .Varint = .Simple }),
        };
    },

    pub const _desc_table = .{
        .normal_field = fd(8, .{ .Varint = .Simple }),
        .repeated_field = fd(9, .{ .List = .String }),
        .partial_oneof = fd(null, .{ .OneOf = std.meta.Child(std.meta.FieldType(@This(), .partial_oneof)) }),
        .recursive_oneof = fd(null, .{ .OneOf = std.meta.Child(std.meta.FieldType(@This(), .recursive_oneof)) }),
        .default_oneof_a = fd(null, .{ .OneOf = std.meta.Child(std.meta.FieldType(@This(), .default_oneof_a)) }),
        .default_oneof_b = fd(null, .{ .OneOf = std.meta.Child(std.meta.FieldType(@This(), .default_oneof_b)) }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const TestEndsWithBytes = struct {
    value: ?i32 = null,
    data: ?ManagedString = null,

    pub const _desc_table = .{
        .value = fd(1, .{ .Varint = .Simple }),
        .data = fd(2, .String),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const TestMapFieldsNoBinary = struct {
    map_string_string: ArrayList(MapStringStringEntry),
    map_string_int32: ArrayList(MapStringInt32Entry),
    map_string_int64: ArrayList(MapStringInt64Entry),
    map_string_bool: ArrayList(MapStringBoolEntry),
    map_string_double: ArrayList(MapStringDoubleEntry),
    map_string_enum: ArrayList(MapStringEnumEntry),
    map_string_msg: ArrayList(MapStringMsgEntry),
    map_int32_string: ArrayList(MapInt32StringEntry),
    map_int64_string: ArrayList(MapInt64StringEntry),
    map_bool_string: ArrayList(MapBoolStringEntry),
    test_map_fields: ?TestMapFieldsNoBinary = null,
    map_string_testmapfields: ArrayList(MapStringTestmapfieldsEntry),

    pub const _desc_table = .{
        .map_string_string = fd(1, .{ .List = .{ .SubMessage = {} } }),
        .map_string_int32 = fd(2, .{ .List = .{ .SubMessage = {} } }),
        .map_string_int64 = fd(3, .{ .List = .{ .SubMessage = {} } }),
        .map_string_bool = fd(4, .{ .List = .{ .SubMessage = {} } }),
        .map_string_double = fd(5, .{ .List = .{ .SubMessage = {} } }),
        .map_string_enum = fd(6, .{ .List = .{ .SubMessage = {} } }),
        .map_string_msg = fd(7, .{ .List = .{ .SubMessage = {} } }),
        .map_int32_string = fd(8, .{ .List = .{ .SubMessage = {} } }),
        .map_int64_string = fd(9, .{ .List = .{ .SubMessage = {} } }),
        .map_bool_string = fd(10, .{ .List = .{ .SubMessage = {} } }),
        .test_map_fields = fd(11, .{ .SubMessage = {} }),
        .map_string_testmapfields = fd(12, .{ .List = .{ .SubMessage = {} } }),
    };

    pub const MapStringStringEntry = struct {
        key: ?ManagedString = null,
        value: ?ManagedString = null,

        pub const _desc_table = .{
            .key = fd(1, .String),
            .value = fd(2, .String),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapStringInt32Entry = struct {
        key: ?ManagedString = null,
        value: ?i32 = null,

        pub const _desc_table = .{
            .key = fd(1, .String),
            .value = fd(2, .{ .Varint = .Simple }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapStringInt64Entry = struct {
        key: ?ManagedString = null,
        value: ?i64 = null,

        pub const _desc_table = .{
            .key = fd(1, .String),
            .value = fd(2, .{ .Varint = .Simple }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapStringBoolEntry = struct {
        key: ?ManagedString = null,
        value: ?bool = null,

        pub const _desc_table = .{
            .key = fd(1, .String),
            .value = fd(2, .{ .Varint = .Simple }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapStringDoubleEntry = struct {
        key: ?ManagedString = null,
        value: ?f64 = null,

        pub const _desc_table = .{
            .key = fd(1, .String),
            .value = fd(2, .{ .FixedInt = .I64 }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapStringEnumEntry = struct {
        key: ?ManagedString = null,
        value: ?MapValueEnumNoBinary = null,

        pub const _desc_table = .{
            .key = fd(1, .String),
            .value = fd(2, .{ .Varint = .Simple }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapStringMsgEntry = struct {
        key: ?ManagedString = null,
        value: ?MapValueMessageNoBinary = null,

        pub const _desc_table = .{
            .key = fd(1, .String),
            .value = fd(2, .{ .SubMessage = {} }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapInt32StringEntry = struct {
        key: ?i32 = null,
        value: ?ManagedString = null,

        pub const _desc_table = .{
            .key = fd(1, .{ .Varint = .Simple }),
            .value = fd(2, .String),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapInt64StringEntry = struct {
        key: ?i64 = null,
        value: ?ManagedString = null,

        pub const _desc_table = .{
            .key = fd(1, .{ .Varint = .Simple }),
            .value = fd(2, .String),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapBoolStringEntry = struct {
        key: ?bool = null,
        value: ?ManagedString = null,

        pub const _desc_table = .{
            .key = fd(1, .{ .Varint = .Simple }),
            .value = fd(2, .String),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub const MapStringTestmapfieldsEntry = struct {
        key: ?ManagedString = null,
        value: ?TestMapFieldsNoBinary = null,

        pub const _desc_table = .{
            .key = fd(1, .String),
            .value = fd(2, .{ .SubMessage = {} }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const MapValueMessageNoBinary = struct {
    foo: ?i32 = null,

    pub const _desc_table = .{
        .foo = fd(1, .{ .Varint = .Simple }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Deeply = struct {
    pub const _desc_table = .{};

    pub const Nested = struct {
        pub const _desc_table = .{};

        pub const Message = struct {
            count: ?i32 = null,

            pub const _desc_table = .{
                .count = fd(1, .{ .Varint = .Simple }),
            };

            pub usingnamespace protobuf.MessageMixins(@This());
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

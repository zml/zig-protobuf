///! package tests.longs
///! Code generated by zig-protobuf fork !
const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayListU = std.ArrayListUnmanaged;

const protobuf = @import("protobuf");
const ManagedString = protobuf.ManagedString;
const fd = protobuf.fd;

test {
    std.testing.refAllDeclsRecursive(@This());
}

pub const LongsMessage = struct {
    fixed64_field_min: u64 = 0,
    fixed64_field_max: u64 = 0,
    int64_field_min: i64 = 0,
    int64_field_max: i64 = 0,
    sfixed64_field_min: i64 = 0,
    sfixed64_field_max: i64 = 0,
    sint64_field_min: i64 = 0,
    sint64_field_max: i64 = 0,
    uint64_field_min: u64 = 0,
    uint64_field_max: u64 = 0,

    pub const _desc_table = .{
        .fixed64_field_min = fd(1, .{ .FixedInt = .I64 }),
        .fixed64_field_max = fd(2, .{ .FixedInt = .I64 }),
        .int64_field_min = fd(3, .{ .Varint = .Simple }),
        .int64_field_max = fd(4, .{ .Varint = .Simple }),
        .sfixed64_field_min = fd(5, .{ .FixedInt = .I64 }),
        .sfixed64_field_max = fd(6, .{ .FixedInt = .I64 }),
        .sint64_field_min = fd(7, .{ .Varint = .ZigZagOptimized }),
        .sint64_field_max = fd(8, .{ .Varint = .ZigZagOptimized }),
        .uint64_field_min = fd(9, .{ .Varint = .Simple }),
        .uint64_field_max = fd(10, .{ .Varint = .Simple }),
    };

    pub const encode = protobuf.MessageMixins(@This()).encode;
    pub const decode = protobuf.MessageMixins(@This()).decode;
    pub const deinit = protobuf.MessageMixins(@This()).deinit;
    pub const dupe = protobuf.MessageMixins(@This()).dupe;
    pub const jsonStringify = protobuf.MessageMixins(@This()).jsonStringify;
    pub const json_decode = protobuf.MessageMixins(@This()).json_decode;
    pub const json_encode = protobuf.MessageMixins(@This()).json_encode;
    pub const jsonParse = protobuf.MessageMixins(@This()).jsonParse;
};

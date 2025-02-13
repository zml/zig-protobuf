const std = @import("std");
const testing = std.testing;

const protobuf = @import("protobuf");
const tests = @import("./generated/all.pb.zig");
const proto3 = @import("./generated/test_messages_proto3.pb.zig");
const longs = @import("./generated/msg-long.pb.zig");
const unittest = @import("./generated/unittest.pb.zig");
const longName = @import("./generated/whitespace-in-name.pb.zig");

test "leak in allocated string" {
    var demo: longName.WouldYouParseThisForMePlease = .{};
    defer demo.deinit(testing.allocator);

    // allocate a "dynamic" string
    const allocated = try testing.allocator.dupe(u8, "asd");
    // copy the allocated string
    demo.field = .{ .field = try protobuf.ManagedString.copy(allocated, testing.allocator) };
    // release the allocated string immediately
    testing.allocator.free(allocated);

    const obtained = try demo.encode(testing.allocator);
    defer testing.allocator.free(obtained);

    try testing.expectEqualSlices(u8, "asd", demo.field.?.field.getSlice());
}

test "leak in list of allocated bytes" {
    var my_bytes: std.ArrayListUnmanaged(protobuf.ManagedString) = .{};
    try my_bytes.append(testing.allocator, protobuf.ManagedString{ .Const = "abcdef" });
    defer my_bytes.deinit(testing.allocator);

    var msg = tests.WithRepeatedBytes{
        .byte_field = my_bytes,
    };

    const buffer = try msg.encode(testing.allocator);
    defer testing.allocator.free(buffer);

    var msg_copy = try tests.WithRepeatedBytes.decode(buffer, testing.allocator);
    msg_copy.deinit(testing.allocator);
}

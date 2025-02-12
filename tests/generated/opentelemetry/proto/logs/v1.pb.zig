// Code generated by protoc-gen-zig
///! package opentelemetry.proto.logs.v1
const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

const protobuf = @import("protobuf");
const ManagedString = protobuf.ManagedString;
const fd = protobuf.fd;
/// import package opentelemetry.proto.common.v1
const opentelemetry_proto_common_v1 = @import("../common/v1.pb.zig");
/// import package opentelemetry.proto.resource.v1
const opentelemetry_proto_resource_v1 = @import("../resource/v1.pb.zig");

pub const SeverityNumber = enum(i32) {
    SEVERITY_NUMBER_UNSPECIFIED = 0,
    SEVERITY_NUMBER_TRACE = 1,
    SEVERITY_NUMBER_TRACE2 = 2,
    SEVERITY_NUMBER_TRACE3 = 3,
    SEVERITY_NUMBER_TRACE4 = 4,
    SEVERITY_NUMBER_DEBUG = 5,
    SEVERITY_NUMBER_DEBUG2 = 6,
    SEVERITY_NUMBER_DEBUG3 = 7,
    SEVERITY_NUMBER_DEBUG4 = 8,
    SEVERITY_NUMBER_INFO = 9,
    SEVERITY_NUMBER_INFO2 = 10,
    SEVERITY_NUMBER_INFO3 = 11,
    SEVERITY_NUMBER_INFO4 = 12,
    SEVERITY_NUMBER_WARN = 13,
    SEVERITY_NUMBER_WARN2 = 14,
    SEVERITY_NUMBER_WARN3 = 15,
    SEVERITY_NUMBER_WARN4 = 16,
    SEVERITY_NUMBER_ERROR = 17,
    SEVERITY_NUMBER_ERROR2 = 18,
    SEVERITY_NUMBER_ERROR3 = 19,
    SEVERITY_NUMBER_ERROR4 = 20,
    SEVERITY_NUMBER_FATAL = 21,
    SEVERITY_NUMBER_FATAL2 = 22,
    SEVERITY_NUMBER_FATAL3 = 23,
    SEVERITY_NUMBER_FATAL4 = 24,
    _,
};

pub const LogRecordFlags = enum(i32) {
    LOG_RECORD_FLAGS_DO_NOT_USE = 0,
    LOG_RECORD_FLAGS_TRACE_FLAGS_MASK = 255,
    _,
};

pub const LogsData = struct {
    resource_logs: ArrayList(ResourceLogs),

    pub const _desc_table = .{
        .resource_logs = fd(1, .{ .List = .{ .SubMessage = {} } }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const ResourceLogs = struct {
    resource: ?opentelemetry_proto_resource_v1.Resource = null,
    scope_logs: ArrayList(ScopeLogs),
    schema_url: ManagedString = .Empty,

    pub const _desc_table = .{
        .resource = fd(1, .{ .SubMessage = {} }),
        .scope_logs = fd(2, .{ .List = .{ .SubMessage = {} } }),
        .schema_url = fd(3, .String),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const ScopeLogs = struct {
    scope: ?opentelemetry_proto_common_v1.InstrumentationScope = null,
    log_records: ArrayList(LogRecord),
    schema_url: ManagedString = .Empty,

    pub const _desc_table = .{
        .scope = fd(1, .{ .SubMessage = {} }),
        .log_records = fd(2, .{ .List = .{ .SubMessage = {} } }),
        .schema_url = fd(3, .String),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const LogRecord = struct {
    time_unix_nano: u64 = 0,
    observed_time_unix_nano: u64 = 0,
    severity_number: SeverityNumber = @enumFromInt(0),
    severity_text: ManagedString = .Empty,
    body: ?opentelemetry_proto_common_v1.AnyValue = null,
    attributes: ArrayList(opentelemetry_proto_common_v1.KeyValue),
    dropped_attributes_count: u32 = 0,
    flags: u32 = 0,
    trace_id: ManagedString = .Empty,
    span_id: ManagedString = .Empty,

    pub const _desc_table = .{
        .time_unix_nano = fd(1, .{ .FixedInt = .I64 }),
        .observed_time_unix_nano = fd(11, .{ .FixedInt = .I64 }),
        .severity_number = fd(2, .{ .Varint = .Simple }),
        .severity_text = fd(3, .String),
        .body = fd(5, .{ .SubMessage = {} }),
        .attributes = fd(6, .{ .List = .{ .SubMessage = {} } }),
        .dropped_attributes_count = fd(7, .{ .Varint = .Simple }),
        .flags = fd(8, .{ .FixedInt = .I32 }),
        .trace_id = fd(9, .Bytes),
        .span_id = fd(10, .Bytes),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

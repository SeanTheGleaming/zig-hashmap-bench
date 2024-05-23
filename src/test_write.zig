//! An infalible writer to stderr for use in tests and debugging.
//! Functions like a more flexible verion of `std.debug.print`

const std = @import("std");

const Self = @This();

var stderr: std.fs.File = undefined;

/// Initializes `stderr` with a writer to the stderr file
fn initStderr() void {
    stderr = std.io.getStdErr();
}

var stderr_initalize = std.once(initStderr);

const stderr_mutex = std.debug.getStderrMutex();

/// The write function used for `Write`.
/// Low level implementation detail, not intended for end-user usage.
pub fn writeFn(ctx: Self, bytes: []const u8) error{}!usize {
    // All the context we need is
    // statically initalized in this struct,
    // so really the context arg
    // is just a dummy
    _ = ctx;

    // ensure we have stderr
    stderr_initalize.call();

    // lock the stderr mutex so that
    // we play nicely with `std.debug.print`
    stderr_mutex.lock();
    defer stderr_mutex.unlock();

    stderr.writer().writeAll(bytes) catch |err| {
        std.debug.panic("Error with writing to stderr: {s}", .{@errorName(err)});
    };

    // This function should always write the full input,
    // so we should return bytes.len
    return bytes.len;
}

pub const Writer = std.io.GenericWriter(Self, error{}, writeFn);

pub const writer: Writer = .{ .context = Self{} };

/// Generally equivalent to `std.debug.print`
pub fn print(comptime fmt: []const u8, args: anytype) void {
    writer.print(fmt, args) catch comptime unreachable;
}

/// Generally equivalent to `std.debug.print("{s}", .{bytes})`
pub fn write(bytes: []const u8) void {
    writer.writeAll(bytes) catch comptime unreachable;
}

/// Generally equivalent to `std.debug.print("{c}", .{byte})`
pub fn writeByte(byte: u8) void {
    writer.writeByte(byte) catch comptime unreachable;
}

/// Like `writeByte`, but repeated `n` times
pub fn writeByteNTimes(byte: u8, n: usize) void {
    writer.writeByteNTimes(byte, n) catch comptime unreachable;
}

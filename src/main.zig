//! Runs benchmakrs on various `std.hash_map` functions/types

const std = @import("std");
const builtin = @import("builtin");
const zbench = @import("zbench");
const test_write = @import("test_write.zig");

const old_map = @import("new_map.zig");
const new_map = @import("old_map.zig");
const std_map = std.hash_map;

const heap = std.heap;
const Allocator = std.mem.Allocator;
const doNotOptimizeAway = std.mem.doNotOptimizeAway;

fn BenchmarkFns(map_namespace: type) type {
    return struct {
        // since we are benchmarking the speed of the
        // actual function calls, and the hashmaps we
        // test on don't need to have anything in them,
        // we don't bother adding any elements to these
        // maps. this has the benefit of not slowing down
        // the benchmarks with memory allocation

        pub fn @"Call contains (unmanaged)"(_: Allocator) void {
            const times = 500000;

            const Map = map_namespace.AutoHashMapUnmanaged(usize, usize);
            var map = Map{};

            doNotOptimizeAway(map);

            const contains = Map.contains;
            const contains_value_pass = @typeInfo(@TypeOf(contains)).Fn.params[0].type.? == Map;

            for (0..times) |i| {
                if (contains_value_pass) {
                    // pass by value
                    const x = @call(.never_inline, contains, .{ map, i });
                    doNotOptimizeAway(x);
                } else {
                    // pass by reference
                    const x = @call(.never_inline, contains, .{ &map, i });
                    doNotOptimizeAway(x);
                }
            }
        }

        pub fn @"Call contains (managed)"(allocator: Allocator) void {
            const times = 500000;

            const Map = map_namespace.AutoHashMap(usize, usize);
            var map = Map.init(allocator);

            doNotOptimizeAway(map);

            const contains = Map.contains;
            const contains_value_pass = @typeInfo(@TypeOf(contains)).Fn.params[0].type.? == Map;

            for (0..times) |i| {
                if (contains_value_pass) {
                    // pass by value
                    const x = @call(.never_inline, contains, .{ map, i });
                    doNotOptimizeAway(x);
                } else {
                    // pass by reference
                    const x = @call(.never_inline, contains, .{ &map, i });
                    doNotOptimizeAway(x);
                }
            }
        }

        pub fn @"Call capacity (unmanaged)"(_: Allocator) void {
            const times = 500000;

            const Map = map_namespace.AutoHashMapUnmanaged(usize, usize);
            var map = Map{};

            doNotOptimizeAway(map);

            const capacity = Map.capacity;
            const capacity_value_pass = @typeInfo(@TypeOf(capacity)).Fn.params[0].type.? == Map;

            for (0..times) |_| {
                if (capacity_value_pass) {
                    // pass by value
                    const x = @call(.never_inline, capacity, .{map});
                    doNotOptimizeAway(x);
                } else {
                    // pass by reference
                    const x = @call(.never_inline, capacity, .{&map});
                    doNotOptimizeAway(x);
                }
            }
        }

        pub fn @"Call capacity (managed)"(allocator: Allocator) void {
            const times = 500000;

            const Map = map_namespace.AutoHashMap(usize, usize);
            var map = Map.init(allocator);

            doNotOptimizeAway(map);

            const capacity = Map.capacity;
            const capacity_value_pass = @typeInfo(@TypeOf(capacity)).Fn.params[0].type.? == Map;

            for (0..times) |_| {
                if (capacity_value_pass) {
                    // pass by value
                    const x = @call(.never_inline, capacity, .{map});
                    doNotOptimizeAway(x);
                } else {
                    // pass by reference
                    const x = @call(.never_inline, capacity, .{&map});
                    doNotOptimizeAway(x);
                }
            }
        }

        pub fn @"Call count (unmanaged)"(_: Allocator) void {
            const times = 500000;

            const Map = map_namespace.AutoHashMapUnmanaged(usize, usize);
            var map = Map{};

            doNotOptimizeAway(map);

            const count = Map.count;
            const count_value_pass = @typeInfo(@TypeOf(count)).Fn.params[0].type.? == Map;

            for (0..times) |_| {
                if (count_value_pass) {
                    // pass by value
                    const x = @call(.never_inline, count, .{map});
                    doNotOptimizeAway(x);
                } else {
                    // pass by reference
                    const x = @call(.never_inline, count, .{&map});
                    doNotOptimizeAway(x);
                }
            }
        }

        pub fn @"Call count (managed)"(allocator: Allocator) void {
            const times = 500000;

            const Map = map_namespace.AutoHashMap(usize, usize);
            var map = Map.init(allocator);

            doNotOptimizeAway(map);

            const count = Map.count;
            const count_value_pass = @typeInfo(@TypeOf(count)).Fn.params[0].type.? == Map;

            for (0..times) |_| {
                if (count_value_pass) {
                    // pass by value
                    const x = @call(.never_inline, count, .{map});
                    doNotOptimizeAway(x);
                } else {
                    // pass by reference
                    const x = @call(.never_inline, count, .{&map});
                    doNotOptimizeAway(x);
                }
            }
        }

        pub fn @"Call get (unmanaged)"(_: Allocator) void {
            const times = 500000;

            const Map = map_namespace.AutoHashMapUnmanaged(usize, usize);
            var map = Map{};

            doNotOptimizeAway(map);

            const get = Map.get;
            const get_value_pass = @typeInfo(@TypeOf(get)).Fn.params[0].type.? == Map;

            for (0..times) |i| {
                if (get_value_pass) {
                    // pass by value
                    const x = @call(.never_inline, get, .{ map, i });
                    doNotOptimizeAway(x);
                } else {
                    // pass by reference
                    const x = @call(.never_inline, get, .{ &map, i });
                    doNotOptimizeAway(x);
                }
            }
        }

        pub fn @"Call get (managed)"(allocator: Allocator) void {
            const times = 500000;

            const Map = map_namespace.AutoHashMap(usize, usize);
            var map = Map.init(allocator);

            doNotOptimizeAway(map);

            const get = Map.get;
            const get_value_pass = @typeInfo(@TypeOf(get)).Fn.params[0].type.? == Map;

            for (0..times) |i| {
                if (get_value_pass) {
                    // pass by value
                    const x = @call(.never_inline, get, .{ map, i });
                    doNotOptimizeAway(x);
                } else {
                    // pass by reference
                    const x = @call(.never_inline, get, .{ &map, i });
                    doNotOptimizeAway(x);
                }
            }
        }

        pub fn @"Many calls (unmanaged)"(_: Allocator) void {
            const times = 500000;

            const Map = map_namespace.AutoHashMapUnmanaged(usize, usize);
            var map = Map{};

            doNotOptimizeAway(map);

            const single_arg_methods = .{ Map.count, Map.capacity };
            const index_arg_methods = .{ Map.get, Map.contains };

            for (0..times) |i| {
                inline for (single_arg_methods) |method| {
                    const value_pass = @typeInfo(@TypeOf(method)).Fn.params[0].type.? == Map;
                    if (value_pass) {
                        // pass by value
                        const x = @call(.never_inline, method, .{map});
                        doNotOptimizeAway(x);
                    } else {
                        // pass by reference
                        const x = @call(.never_inline, method, .{&map});
                        doNotOptimizeAway(x);
                    }
                }

                inline for (index_arg_methods) |method| {
                    const value_pass = @typeInfo(@TypeOf(method)).Fn.params[0].type.? == Map;
                    if (value_pass) {
                        // pass by value
                        const x = @call(.never_inline, method, .{ map, i });
                        doNotOptimizeAway(x);
                    } else {
                        // pass by reference
                        const x = @call(.never_inline, method, .{ &map, i });
                        doNotOptimizeAway(x);
                    }
                }
            }
        }

        pub fn @"Many calls (managed)"(allocator: Allocator) void {
            const times = 500000;

            const Map = map_namespace.AutoHashMap(usize, usize);
            var map = Map.init(allocator);

            doNotOptimizeAway(map);

            const single_arg_methods = .{ Map.count, Map.capacity };
            const index_arg_methods = .{ Map.get, Map.contains };

            for (0..times) |i| {
                inline for (single_arg_methods) |method| {
                    const value_pass = @typeInfo(@TypeOf(method)).Fn.params[0].type.? == Map;
                    if (value_pass) {
                        // pass by value
                        const x = @call(.never_inline, method, .{map});
                        doNotOptimizeAway(x);
                    } else {
                        // pass by reference
                        const x = @call(.never_inline, method, .{&map});
                        doNotOptimizeAway(x);
                    }
                }

                inline for (index_arg_methods) |method| {
                    const value_pass = @typeInfo(@TypeOf(method)).Fn.params[0].type.? == Map;
                    if (value_pass) {
                        // pass by value
                        const x = @call(.never_inline, method, .{ map, i });
                        doNotOptimizeAway(x);
                    } else {
                        // pass by reference
                        const x = @call(.never_inline, method, .{ &map, i });
                        doNotOptimizeAway(x);
                    }
                }
            }
        }
    };
}

inline fn benchmarks(comptime map_namespace: type) [@typeInfo(BenchmarkFns(map_namespace)).Struct.decls.len]Bench {
    const fns = BenchmarkFns(map_namespace);

    const length = @typeInfo(fns).Struct.decls.len;
    comptime var bench_list: [length]Bench = undefined;

    comptime {
        for (&bench_list, @typeInfo(fns).Struct.decls) |*b, func| {
            b.* = .{ .name = func.name, .func = &@field(fns, func.name) };
        }
    }

    return bench_list;
}

const Bench = struct {
    name: []const u8,
    func: *const fn (std.mem.Allocator) void,
};

pub fn main() !void {
    var gpa = heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const info = .{
        .optimize = @tagName(builtin.mode),
        .arch = @tagName(builtin.cpu.arch),
        .cpu = builtin.cpu.model.name,
        .os = @tagName(builtin.os.tag),
    };

    const stdout = std.io.getStdOut().writer();

    try stdout.print(
        \\Running benchmarks
        \\Optimization mode: {[optimize]s}
        \\CPU arch: {[arch]s}
        \\OS: {[os]s}
        \\CPU model: {[cpu]s}
        \\
    , info);

    var benchmark_runner = zbench.Benchmark.init(allocator, .{});
    defer benchmark_runner.deinit();

    var arena = heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const fmt_arena = arena.allocator();

    // test the old implementation, the new implementation, and the current std implementation
    for (benchmarks(old_map), benchmarks(new_map)) |old_bench, new_bench| {
        const config = .{ .iterations = 1024 };
        const allocPrint = std.fmt.allocPrint;

        const benches = [_]Bench{ old_bench, new_bench };
        const prefixes = [_][]const u8{ "ptr-arg", "val-arg" };
        for (benches, prefixes) |bench, prefix| {
            try benchmark_runner.add(
                try allocPrint(fmt_arena, "{s} hashmap: {s}", .{ prefix, bench.name }),
                old_bench.func,
                config,
            );
        }
    }

    try benchmark_runner.run(stdout);
}

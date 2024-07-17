# zig-protobuf

-------

## Welcome!

This is an implementation of google Protocol Buffers version 3 in Zig.

Protocol Buffers is a serialization protocol so systems, from any programming language or platform, can exchange data reliably.

Protobuf's strength lies in a generic codec paired with user-defined "messages" that will define the true nature of the data encoded.

Messages are usually mapped to a native language's structure/class definition thanks to a language-specific generator associated with an implementation.

Zig's compile-time evaluation becomes extremely strong and useful in this context: because the structure (a message) has to be known beforehand, the generic codec can leverage informations, at compile time, of the message and it's nature. This allows optimizations that are hard to get as easily in any other language, as Zig can mix compile-time informations with runtime-only data to optimize the encoding and decoding code paths.


## State of this fork

This fork meant to fix a few issues I had with https://github.com/Arwalk/zig-protobuf/
In particulare it uses:
 
* one `.pb.zig` file per `.proto` file
    - this match what other generators do, and work better with build systems like Bazel.
    - in particular `protoc` passes to the plugin a list of file to generate, and zig-protobuf wasn't respecting that.
* togglable module support
    - instead of importing generated `.pb.zig` files in others `.pb.zig`, it can be nice 
    to use Zig moduls.
    I put a `pub const USE_MODULE = false` to the top of `main.zig` file.
    Change to `true` to generate module names.
    This allows to generate exactly once each `.pb.zig` and include them across folders.
    Note that I haven't added support for individual modules in build.zig.
* anonymous union type to avoid name conflicts
* Official zig-protobuf uses flat struct everywhere. By comparison C++ uses pointers for each submessage.
    - this is nice when possible because it's better for memory locality and simplifies alloc/deallocs.
    - but it can generate code that doesn't compile: `message Foo { Foo x = 1; }` becomes `const Foo = struct { x: Foo }` which doesn't compile.
    - instead this fork detects problematic messages and use pointers there.
    For example `Foo` will become: `Foo = struct { x: ?*const Foo }`.
    Contrary to C++ only self-referential messages are passed by pointers,
    other messages are stored as flat struct.

## How to use

1. Add `protobuf` to your `build.zig.zon`.  
    ```zig
    .{
        .name = "my_project",
        .version = "0.0.1",
        .paths = .{""},
        .dependencies = .{
            .protobuf = .{
                .url = "https://github.com/Arwalk/zig-protobuf/archive/<some-commit-sha>.tar.gz",
                .hash = "12ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
                // leave the hash as is, the build system will tell you which hash to put here based on your commit
            },
        },
    }
    ```
1. Use the `protobuf` module   
    ```zig
    pub fn build(b: *std.Build) !void {
        // first create a build for the dependency
        const protobuf_dep = b.dependency("protobuf", .{
            .target = target,
            .optimize = optimize,
        });

        // and lastly use the dependency as a module
        exe.root_module.addImport("protobuf", protobuf_dep.module("protobuf"));
    }
    ```


## Generating .zig files out of .proto definitions

You can do this programatically as a compilation step for your application. The following snippet shows how to create a `zig build gen-proto` command for your project.

```zig
const protobuf = @import("protobuf");

pub fn build(b: *std.Build) !void {
    // first create a build for the dependency
    const protobuf_dep = b.dependency("protobuf", .{
        .target = target,
        .optimize = optimize,
    });
    
    ...

    const gen_proto = b.step("gen-proto", "generates zig files from protocol buffer definitions");

    const protoc_step = protobuf.RunProtocStep.create(b, protobuf_dep.builder, target, .{
        // out directory for the generated zig files
        .destination_directory = b.path("src/proto"),
        .source_files = &.{
            "protocol/all.proto",
        },
        .include_directories = &.{},
    });

    gen_proto.dependOn(&protoc_step.step);
}
```

If you're really bored, you can buy me a coffe here.

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/N4N7VMS4F)

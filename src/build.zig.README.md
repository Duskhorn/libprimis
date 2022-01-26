# Experimental zig build system branch
[Zig](https://ziglang.org)is a modern low level programming language, currently in its alpha stage.
The standalone compiler offers a drop in replacement for a C and C++ compiler paired with a build system, offering also cross compilation

## How to build using Zig
1. [Get the Zig compiler](https://ziglang.org) and add it to your `$PATH` variable
2. clone the libprimis repo
3. `$ cd {path/to/libprimis}/src/`
4. `$ zig build`

The output `libprimis.so` shuld be in the `src/zig-out/lib` folder

## Todo
- [] add step to install library in `/usr/lib/`
- [] windows compilation
- [] coverage build
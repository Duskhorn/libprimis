const std = @import("std");

const files = &[_][]const u8 {
    "shared/geom.cpp",
    "shared/glemu.cpp",
    "shared/stream.cpp",
    "shared/tools.cpp",
    "shared/zip.cpp",
    "engine/interface/command.cpp",
    "engine/interface/control.cpp",
    "engine/interface/cubestd.cpp",
    "engine/interface/console.cpp",
    "engine/interface/input.cpp",
    "engine/interface/menus.cpp",
    "engine/interface/sound.cpp",
    "engine/interface/textedit.cpp",
    "engine/interface/ui.cpp",
    "engine/model/animmodel.cpp",
    "engine/model/hitzone.cpp",
    "engine/model/obj.cpp",
    "engine/model/ragdoll.cpp",
    "engine/model/skelmodel.cpp",
    "engine/render/aa.cpp",
    "engine/render/ao.cpp",
    "engine/render/csm.cpp",
    "engine/render/grass.cpp",
    "engine/render/hdr.cpp",
    "engine/render/hud.cpp",
    "engine/render/normal.cpp",
    "engine/render/octarender.cpp",
    "engine/render/radiancehints.cpp",
    "engine/render/renderalpha.cpp",
    "engine/render/rendergl.cpp",
    "engine/render/renderlights.cpp",
    "engine/render/rendermodel.cpp",
    "engine/render/renderparticles.cpp",
    "engine/render/rendersky.cpp",
    "engine/render/rendertext.cpp",
    "engine/render/rendertimers.cpp",
    "engine/render/renderva.cpp",
    "engine/render/renderwindow.cpp",
    "engine/render/shader.cpp",
    "engine/render/stain.cpp",
    "engine/render/texture.cpp",
    "engine/render/water.cpp",
    "engine/world/bih.cpp",
    "engine/world/dynlight.cpp",
    "engine/world/heightmap.cpp",
    "engine/world/light.cpp",
    "engine/world/material.cpp",
    "engine/world/mpr.cpp",
    "engine/world/octaedit.cpp",
    "engine/world/octaworld.cpp",
    "engine/world/physics.cpp",
    "engine/world/raycube.cpp",
    "engine/world/world.cpp",
    "engine/world/worldio.cpp",
};

const flags = f: {
    const fl = &[_][]const u8{
        "-O3",
        "-ffast-math",
        "-std=c++17",
        "-march=x86-64",
        "-Wall",
        "-fsigned-char",
        "-fno-rtti",
        "-fpic",
        "-D_GLIBCXX_USE_CXX11_ABI=0"
    };
    break :f fl; //TODO: coverage build flags 
};


pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();
    const libprimis = b.addSharedLibrary("primis", null, .unversioned); //prefix "lib" gets added automatically

    libprimis.addCSourceFiles(files, flags);

    libprimis.addIncludeDir("shared");
    libprimis.addIncludeDir("engine");
    libprimis.addIncludeDir("/usr/include/SDL2");
    libprimis.addIncludeDir("/usr/X11R6/include");

    libprimis.linkLibC();
    libprimis.linkLibCpp();
    libprimis.linkSystemLibrary("m");
    libprimis.linkSystemLibrary("z");
    libprimis.linkSystemLibrary("GL");
    libprimis.linkSystemLibrary("rt");
    libprimis.linkSystemLibrary("X11");
    libprimis.linkSystemLibrary("SDL2");
    libprimis.linkSystemLibrary("SDL2_image");
    libprimis.linkSystemLibrary("SDL2_mixer");
    libprimis.linkSystemLibrary("SDL2_ttf");

    libprimis.setBuildMode(mode);
    libprimis.install();

}
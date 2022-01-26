const std = @import("std");

const files = &[_][]const u8 {
    "shared/crypto.c",
    "shared/geom.c",
    "shared/glemu.c",
    "shared/stream.c",
    "shared/tools.c",
    "shared/zip.c",
    "engine/interface/command.c",
    "engine/interface/control.c",
    "engine/interface/cubestd.c",
    "engine/interface/console.c",
    "engine/interface/input.c",
    "engine/interface/menus.c",
    "engine/interface/sound.c",
    "engine/interface/textedit.c",
    "engine/interface/ui.c",
    "engine/model/animmodel.c",
    "engine/model/hitzone.c",
    "engine/model/obj.c",
    "engine/model/ragdoll.c",
    "engine/model/skelmodel.c",
    "engine/render/aa.c",
    "engine/render/ao.c",
    "engine/render/csm.c",
    "engine/render/grass.c",
    "engine/render/hdr.c",
    "engine/render/hud.c",
    "engine/render/normal.c",
    "engine/render/octarender.c",
    "engine/render/radiancehints.c",
    "engine/render/renderalpha.c",
    "engine/render/rendergl.c",
    "engine/render/renderlights.c",
    "engine/render/rendermodel.c",
    "engine/render/renderparticles.c",
    "engine/render/rendersky.c",
    "engine/render/rendertext.c",
    "engine/render/rendertimers.c",
    "engine/render/renderva.c",
    "engine/render/renderwindow.c",
    "engine/render/shader.c",
    "engine/render/stain.c",
    "engine/render/texture.c",
    "engine/render/water.c",
    "engine/world/bih.c",
    "engine/world/dynlight.c",
    "engine/world/heightmap.c",
    "engine/world/light.c",
    "engine/world/material.c",
    "engine/world/mpr.c",
    "engine/world/octaedit.c",
    "engine/world/octaworld.c",
    "engine/world/physics.c",
    "engine/world/raycube.c",
    "engine/world/world.c",
    "engine/world/worldio.c",
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
        "-fpic"
    };
    break :f fl; //TODO: coverage build flags 
};


pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();
    const libprimis = b.addSharedLibrary("libprimis.so", null);

    libprimis.addCSourceFiles(files, &[_][]const u8{});

    libprimis.addIncludeDir("shared");
    libprimis.addIncludeDir("engine");
    libprimis.addIncludeDir("/usr/X11R6/include");

    libprimis.linkLibCpp();
    libprimis.linkSystemLibrary("libm");
    libprimis.linkSystemLibrary("libz");
    libprimis.linkSystemLibrary("libGL");
    libprimis.linkSystemLibrary("librt");
    libprimis.linkSystemLibrary("libX11");
    libprimis.linkSystemLibrary("libSDL2");
    libprimis.linkSystemLibrary("libSDL2_image");
    libprimis.linkSystemLibrary("libSDL2_mixer");
    libprimis.linkSystemLibrary("libSDL2_ttf");


    libprimis.setBuildMode(mode);
    libprimis.install();

}
# cgame-engine

A small 2D game engine written from scratch in C99 on top of SDL2 and OpenGL 3.3 Core,
plus a sample platformer-shooter built with it.

## Features

- **Renderer**: OpenGL 3.3 Core with a batched quad renderer (up to 8 texture slots per batch),
  sprite sheets, and debug primitives (lines, quad outlines, AABBs)
- **Animation**: frame-based sprite animation with per-frame duration, looping and horizontal flip
- **Physics**: AABB collision, swept AABB (ray vs AABB, slab method) to prevent tunneling,
  collision response against static geometry, gravity with terminal velocity, and sub-stepped integration
- **Collision filtering**: per-body `collision_layer` / `collision_mask` bitfields with
  `on_hit` / `on_hit_static` callbacks, plus kinematic bodies and trigger volumes
- **Entities**: pooled entities backed by physics bodies, with slot reuse on destroy
- **Audio**: SDL_mixer sound effects (WAV) and streamed music (MP3/OGG)
- **Core**: `config.ini` key bindings, keyboard input state, a fixed frame-rate timer,
  file I/O, and a generic `Array_List` container

## Project layout

```
cgame-engine/
├── include/            Third-party headers (SDL2, glad, KHR, FreeType, linmath, stb_image)
├── lib/                Prebuilt Windows import libs (SDL2, SDL2_mixer, FreeType)
└── game/
    ├── build.bat       MSVC build script
    ├── clean.bat       Removes build artifacts and config.ini
    ├── Makefile        GCC build (Linux)
    ├── assets/         Sprites, fonts, sound effects, music
    ├── shaders/        GLSL shaders (default, batch_quad)
    └── src/
        ├── main.c      Sample game: player, enemies, weapons, level setup
        ├── glad.c      OpenGL loader
        └── engine/     Engine modules: <module>.h public API, <module>/<module>.c implementation
            ├── render/  animation/  physics/  entity/  audio/
            └── config/  input/  time/  io/  array_list/  global/
```

## Building

### Windows (MSVC)

Run from a **Developer Command Prompt for Visual Studio**:

```bat
cd game
build.bat
mygame.exe
```

`build.bat` uses absolute paths to `include/` and `lib/` (`C:\Work\cgame-engine\...`).
If the repository lives elsewhere, update the `/I` and `libs` paths in the script.
The SDL2 and codec DLLs the game needs are already in `game/`.

To remove build artifacts:

```bat
clean.bat
```

### Linux (GCC)

Install SDL2 and SDL2_mixer development packages, then:

```sh
cd game
make
./mygame.out
```

> The Makefile is not up to date yet: it references `render_init.c` (should be
> `render_internal.c`) and `src/engine/global.c` (should be `src/engine/global/global.c`),
> and calls `sdl1-config` instead of `sdl2-config`. Fix these before building on Linux.

## Controls

Key bindings are stored in `game/config.ini`. The file is created with these defaults on first run:

| Action     | Key    |
|------------|--------|
| Move left  | A      |
| Move right | D      |
| Jump       | W      |
| Shoot      | E      |
| Quit       | Escape |

Delete `config.ini` to restore the defaults.

## Sample game

`game/src/main.c` is a single-screen arena game in the style of *Super Crate Box*:

- Enemies spawn on a timer and patrol, turning around when they hit a wall.
  Enemies that fall into the fire at the bottom come back enraged: faster, and with a different animation.
- Weapons: pistol, revolver, shotgun, SMG and rocket launcher, each with its own
  fire rate, recoil, projectile speed and projectile type.
- If the player falls into the fire, the level resets. Player vs enemy contact is not implemented yet
  (`player_on_hit` is empty).

## Dependencies

All of these are vendored in the repository:

- [SDL2](https://www.libsdl.org/) and [SDL2_mixer](https://github.com/libsdl-org/SDL_mixer)
- [glad](https://glad.dav1d.de/): OpenGL 3.3 Core loader
- [linmath.h](https://github.com/datenwolf/linmath.h): vector and matrix math
- [stb_image](https://github.com/nothings/stb): image loading
- [FreeType](https://freetype.org/): linked, not used yet

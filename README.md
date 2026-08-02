# Primeval Boats

[Русская версия](/docs/ru/README.md)

**Primitive wooden boats with realistic physics.**

A content pack for [VoxelCore](https://github.com/MihailRis/voxelcore) that adds wooden boats, rafts, and kayaks.

*Note: Documentation was written with the assistance of AI.*

## Features

- **Multiple boat types** — standard boat, log raft, kayak
- **Realistic water physics** — boats have inertia, smooth acceleration, and can tilt
- **Mounting system** — via [RideableAPI](https://github.com/Neveix/voxelcore-rideable-api)
- **Inventory support** — store items inside some boats
- [New-Generation](https://github.com/EsPaKira/New-Generation) integration
- **Water splashes** — visual feedback when moving or falling

## Installation

- Ensure dependencies are installed:
   - [RideableAPI](https://github.com/Neveix/voxelcore-rideable-api)
   - [Interactive Commons](https://github.com/Neveix/voxelcore-interactive-commons)

- Optional dependencies:
   - [New-Generation](https://github.com/EsPaKira/New-Generation) (>=0.6.0)

## For Players

Craft your boat and set sail!

- **Raft** — cheap, slow, but carries a lot
- **Boat** — the classic choice for exploration
- **Kayak** — fast and nimble, but no storage

**Controls:**
- `WASD` — movement
- `Right-click` — mount
- `Right-click + Shift` — open inventory (if boat has storage)
- `Shift` — dismount

### Crafting Recipes


| Boat | Recipe |
| :--- | :--- |
| **Log Raft** | 4 Wood + 10 Flax Fiber |
| **Plank Boat** | 10 Planks + 2 Tin Bronze Nugget + 10 Red Clay Chunk |
| **Kayak** | 20 Bone + 4 Fur |


## For Developers

This pack is built on [Interactive Commons](https://github.com/Neveix/voxelcore-interactive-commons) (`intcom`) and demonstrates its boat presets in action.

### What this pack shows

- How to configure boat parameters (speed, acceleration, roll)
- How to override default behavior via `modules/interact/boat/`
- How to add inventory support

### Create your own boats

You can easily add custom boats to your own pack. 

Just use the documentation of [Interactive Commons](https://github.com/Neveix/voxelcore-interactive-commons)

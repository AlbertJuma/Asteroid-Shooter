# Copilot Instructions for Asteroid Shooter

## Project Overview
Classic arcade-style space shooter built with **Godot 4.x**. Complete, playable game with all core systems implemented. Uses GDScript and Godot's built-in physics/scene system.

## Technology Stack
- **Engine**: Godot 4.3 (Forward+ renderer)
- **Language**: GDScript
- **Graphics**: Polygon2D primitives (no external assets)
- **Architecture**: Scene-based with node composition

## Project Structure
```
scripts/        # All GDScript (.gd) files
scenes/         # Godot scene files (.tscn) - must be built in editor
ui/             # UI built within Main.tscn (CanvasLayers)
assets/         # Empty (no external assets used)
```

## Key Systems & Architecture

### Game Manager Pattern (`scripts/GameManager.gd`)
- **State Machine**: Enum-based (MENU, PLAYING, GAME_OVER)
- **Spawning System**: Timer-based asteroid spawning from screen edges
- **Difficulty Scaling**: Adds asteroids every 500 points
- **Scene References**: Uses @export PackedScene for Player/Asteroid
- **Group Communication**: Calls functions via `get_tree().call_group()`

### Player System (`scripts/Player.gd`)
- **Physics**: CharacterBody2D with custom movement (not RigidBody2D)
- **Movement**: Rotation + forward thrust with friction decay
- **Shooting**: Cooldown-based with Timer, spawns bullets at Marker2D position
- **Screen Wrap**: Manual position checking, wraps at viewport edges
- **Death**: Spawns explosion via preload(), calls game manager via group

### Entity Systems
- **Asteroids** (`Asteroid.gd`): RigidBody2D with 3 size variants, splits on death
- **Bullets** (`Bullet.gd`): Area2D with lifetime auto-cleanup
- **Explosions** (`Explosion.gd`): Pure code-generated Line2D particles

### Collision Architecture
- **Player**: CharacterBody2D detects asteroids via body_entered signal
- **Bullets**: Area2D detects asteroids via body_entered signal
- **Asteroids**: RigidBody2D (passive collision target)
- All use Godot's default Layer 1 for simplicity

### UI Structure
- **HUD**: CanvasLayer with score Label (top-left)
- **StartMenu**: Control with ColorRect overlay + VBoxContainer
- **GameOver**: Similar to StartMenu, shows score/high score
- All UI built directly in Main.tscn (not separate scenes)

## Godot-Specific Patterns

### Scene References
Export PackedScenes, instantiate with `.instantiate()`, add with `add_child()`:
```gdscript
@export var bullet_scene: PackedScene
var bullet = bullet_scene.instantiate()
get_parent().add_child(bullet)
```

### Groups for Communication
Add to group: `add_to_group("player")`
Call all: `get_tree().call_group("game_manager", "add_score", 100)`

### Signal Connections
Connect in code: `shoot_timer.timeout.connect(_on_shoot_timer_timeout)`
Or via editor Node dock

### Screen Wrapping Pattern
```gdscript
var screen_size = get_viewport_rect().size
if global_position.x > screen_size.x:
    global_position.x = 0
```

## Development Workflow

### Running the Game
- **F5**: Play project (runs Main.tscn)
- **F6**: Play current scene
- Scenes must be built in Godot editor (see SCENE_SETUP.md)

### Input Actions (Project Settings)
- `move_left`, `move_right`, `move_up`: WASD + Arrow keys
- `shoot`: Space
- `ui_cancel`, `ui_accept`: Built-in (ESC, Enter)

### Testing Approach
Manual playtesting only. Check:
- Player movement/shooting
- Asteroid spawning and splitting
- Score increases and difficulty scales
- UI state transitions
- Screen wrapping

## Common Modifications

### Adjust Difficulty
`GameManager.gd`: Change `base_asteroid_count` or `difficulty_increase_score`

### Tweak Physics
`Player.gd`: Modify `@export` vars (rotation_speed, thrust_power, etc.)

### Change Scoring
`Asteroid.gd`: Edit `SCORE_VALUES` const dictionary

### Add Features
- **Sound**: Add AudioStreamPlayer nodes, call `.play()`
- **Particles**: Replace Line2D explosions with GPUParticles2D
- **Power-ups**: New scene inheriting Area2D, detect player collision

## Godot 4.x Specifics

### Syntax Changes from Godot 3.x
- `@export` instead of `export`
- `@onready` instead of `onready`
- `CharacterBody2D` replaces `KinematicBody2D`
- `move_and_slide()` no longer takes velocity parameter

### Node Naming
All nodes use exact names referenced in scripts:
- `Muzzle` (Marker2D) - bullet spawn point
- `ShootTimer` (Timer) - cooldown
- `SpawnTimer` (Timer) - asteroid spawning
- `ScoreLabel` (Label) - HUD display

## Documentation Files
- **README.md**: Complete user guide
- **SETUP_INSTRUCTIONS.md**: How to build scenes in Godot
- **SCENE_SETUP.md**: Complete node hierarchies and properties
- **UI_DESIGN.md**: UI layouts and styling
- **GAME_OVERVIEW.md**: Game description and controls

## Critical Notes for AI Agents
- **Scenes are NOT code**: .tscn files must be built in Godot editor, not generated
- **Always use groups**: For cross-node communication (game_manager, player, asteroid, bullet)
- **Screen size**: Get via `get_viewport_rect().size`, not hardcoded
- **Signal connections**: Prefer code connections for clarity in this project
- **Preload for one-time**: Use `preload()` for Explosion, `@export` for reused scenes
- **Physics nodes matter**: CharacterBody2D vs RigidBody2D vs Area2D have different behaviors
- **No external assets**: Everything uses Polygon2D shapes with vertex arrays

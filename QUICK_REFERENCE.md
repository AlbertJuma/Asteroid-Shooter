# Quick Reference Guide

Fast lookup for common tasks when developing the Asteroid Shooter game.

---

## 🚀 Quick Start Commands

```bash
# Run in Godot
Press F5 (or click ▶️ Play button)

# Test current scene only
Press F6

# Stop game
Press F8
```

---

## 📁 File Locations

| Component | Script | Scene |
|-----------|--------|-------|
| Game Manager | `scripts/GameManager.gd` | Built into `scenes/Main.tscn` |
| Player Ship | `scripts/Player.gd` | `scenes/Player.tscn` |
| Bullet | `scripts/Bullet.gd` | `scenes/Bullet.tscn` |
| Asteroid | `scripts/Asteroid.gd` | `scenes/Asteroid.tscn` |
| Explosion | `scripts/Explosion.gd` | `scenes/Explosion.tscn` |
| UI | Built into `scripts/GameManager.gd` | Built into `scenes/Main.tscn` |

---

## 🎮 Input Actions

Configure in **Project → Project Settings → Input Map**

| Action | Keys | Purpose |
|--------|------|---------|
| `move_left` | A, Left Arrow | Rotate ship left |
| `move_right` | D, Right Arrow | Rotate ship right |
| `move_up` | W, Up Arrow | Thrust forward |
| `shoot` | Space | Fire bullet |
| `ui_cancel` | ESC | Return to menu |
| `ui_accept` | Enter | Start/restart game |

---

## 🔧 Common Tweaks

### Difficulty Settings
**File**: `scripts/GameManager.gd`

```gdscript
@export var base_asteroid_count: int = 3          # Starting asteroids
@export var difficulty_increase_score: int = 500   # Score to add asteroid
```

### Player Movement
**File**: `scripts/Player.gd`

```gdscript
@export var rotation_speed: float = 200.0   # Degrees/sec
@export var thrust_power: float = 500.0     # Acceleration
@export var max_speed: float = 400.0        # Max velocity
@export var friction: float = 0.98          # Slowdown rate
@export var shoot_cooldown: float = 0.25    # Seconds between shots
```

### Asteroid Speed
**File**: `scripts/Asteroid.gd`

```gdscript
@export var base_speed: float = 100.0        # Movement speed
@export var rotation_speed: float = 50.0     # Spin speed
```

### Score Values
**File**: `scripts/Asteroid.gd`

```gdscript
const SCORE_VALUES = {
    AsteroidSize.LARGE: 20,
    AsteroidSize.MEDIUM: 50,
    AsteroidSize.SMALL: 100
}
```

### Bullet Properties
**File**: `scripts/Bullet.gd`

```gdscript
@export var speed: float = 600.0      # Bullet velocity
@export var lifetime: float = 2.0     # Seconds before destroy
```

---

## 🎨 Visual Customization

### Player Ship Color
**Scene**: `Player.tscn`
- Select `Sprite2D` (Polygon2D) node
- Inspector → Color → Choose color

### Asteroid Color
**Scene**: `Asteroid.tscn`
- Select `Sprite2D` (Polygon2D) node
- Inspector → Color → Choose color

### Bullet Color
**Scene**: `Bullet.tscn`
- Select `Sprite2D` (Polygon2D) node
- Inspector → Color → Choose color

### Explosion Color
**File**: `scripts/Explosion.gd`

```gdscript
line.default_color = Color(1.0, 0.8, 0.2)  # Yellow-orange
```

### UI Text Colors
**Scene**: `Main.tscn`
- Select Label node
- Inspector → Theme Overrides → Colors → Font Color

---

## 🐛 Debug Commands

Add to any script to print debug info:

```gdscript
# Print to console
print("Player position: ", position)

# Print with label
print("Score: ", score)

# Error message
push_error("Something went wrong!")

# Warning message
push_warning("This might be an issue")
```

---

## 🔍 Node Paths Reference

### Main.tscn Hierarchy
```
Main (Node2D)
├── GameManager (Node)
│   └── SpawnTimer (Timer)
├── HUD (CanvasLayer)
│   └── ScoreLabel (Label)
└── UI (CanvasLayer)
    ├── StartMenu (Control)
    └── GameOver (Control)
```

### Access in Code
```gdscript
# From GameManager script
var hud = $"../HUD"
var score_label = $"../HUD/ScoreLabel"
var start_menu = $"../UI/StartMenu"
```

---

## 📊 Groups Reference

| Group Name | Members | Purpose |
|------------|---------|---------|
| `game_manager` | GameManager node | Call game-wide functions |
| `player` | Player ship | Reference player easily |
| `asteroid` | All asteroids | Cleanup, counting |
| `bullet` | All bullets | Cleanup |

### Using Groups
```gdscript
# Add to group
add_to_group("player")

# Call function on all members
get_tree().call_group("game_manager", "add_score", 100)

# Remove all in group
get_tree().call_group("asteroid", "queue_free")
```

---

## 🎯 Signals Reference

### Player.gd
```gdscript
body_entered   # Collided with asteroid
```

### Bullet.gd
```gdscript
body_entered   # Hit an asteroid
```

### Timer Nodes
```gdscript
timeout        # Timer finished
```

### Button Nodes
```gdscript
pressed        # Button clicked
```

---

## 🛠️ Common Tasks

### Add New Enemy Type
1. Duplicate `Asteroid.tscn` → Rename
2. Modify visual (Polygon2D)
3. Adjust script or create new script
4. Add spawning logic to `GameManager.gd`

### Add Sound Effect
1. Add AudioStreamPlayer node to scene
2. Load audio file in Inspector
3. Call `$AudioPlayer.play()` in script

### Add Power-up
1. Create new scene (Area2D)
2. Add visual and collision shape
3. Create script with `body_entered` signal
4. Check if body is player, apply effect

### Change Window Size
**Project → Project Settings → Display → Window**
- Viewport Width: 1280 (default)
- Viewport Height: 720 (default)

---

## 📝 GDScript Quick Syntax

### Variables
```gdscript
var score: int = 0
var name: String = "Player"
var position: Vector2 = Vector2.ZERO
@export var speed: float = 100.0
```

### Functions
```gdscript
func my_function(param: int) -> void:
    print(param)

func calculate(a: int, b: int) -> int:
    return a + b
```

### Input
```gdscript
# Check if pressed
if Input.is_action_pressed("shoot"):
    shoot()

# Get axis (-1, 0, 1)
var direction = Input.get_axis("move_left", "move_right")
```

### Timers
```gdscript
# One-shot timer
await get_tree().create_timer(1.0).timeout
print("1 second passed")

# Repeating timer node
$Timer.wait_time = 2.0
$Timer.timeout.connect(_on_timer_timeout)
$Timer.start()
```

### Instantiation
```gdscript
var bullet = bullet_scene.instantiate()
bullet.position = Vector2(100, 100)
get_parent().add_child(bullet)
```

---

## 🚨 Troubleshooting Quick Fixes

| Problem | Solution |
|---------|----------|
| "Invalid get index" | Node name typo or node doesn't exist |
| Player doesn't move | Check Input Map is configured |
| No bullets spawn | Assign Bullet Scene in Player Inspector |
| No collisions | Add CollisionShape2D to nodes |
| UI doesn't show | Check CanvasLayer nodes, visibility |
| Scene not found | Use `res://` path, check spelling |

---

## 📚 Documentation Index

- **[README.md](README.md)**: Complete overview and feature list
- **[GAME_OVERVIEW.md](GAME_OVERVIEW.md)**: Game description and controls
- **[SETUP_INSTRUCTIONS.md](SETUP_INSTRUCTIONS.md)**: Full setup guide
- **[SCENE_SETUP.md](SCENE_SETUP.md)**: Complete scene hierarchies
- **[UI_DESIGN.md](UI_DESIGN.md)**: UI layouts and styling

---

## ⚡ Performance Tips

- **Object Pooling**: Reuse bullets instead of instantiate/free (advanced)
- **Limit Max Objects**: Cap asteroid count in GameManager
- **Use call_deferred()**: For add_child during physics callbacks
- **Spatial Partitioning**: For many objects (not needed at this scale)

---

## 🎓 Learning Next Steps

1. **Add audio** - AudioStreamPlayer nodes
2. **Particles** - GPUParticles2D for explosions
3. **Shaders** - Custom visual effects
4. **Networking** - Multiplayer (advanced)
5. **Mobile** - Touch controls and export

---

**Quick Reference v1.0** | Asteroid Shooter | Godot 4.x

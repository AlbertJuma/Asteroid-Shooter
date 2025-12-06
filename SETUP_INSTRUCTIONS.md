# Setup and Run Instructions

Complete guide to setting up and running the Asteroid Shooter game in Godot 4.x.

---

## Prerequisites

### Required Software
- **Godot 4.x** (4.0 or higher)
  - Download from: https://godotengine.org/download
  - Choose "Standard" version (not .NET/Mono unless you prefer C#)
  - Supports Windows, macOS, and Linux

### System Requirements
- **OS**: Windows 7+, macOS 10.13+, or Linux (any modern distro)
- **RAM**: 2GB minimum, 4GB+ recommended
- **Storage**: ~200MB for Godot + minimal space for project
- **Display**: Any resolution (designed for 1280x720 base)

---

## Initial Project Setup

### Option 1: Import Existing Project

If you cloned/downloaded this repository:

1. **Launch Godot**
2. **Click "Import"** on the Project Manager
3. **Navigate to the project folder** (`asteroid-shooter/`)
4. **Select `project.godot`** file
5. **Click "Import & Edit"**

### Option 2: Create New Project

If starting from scratch with these files:

1. **Launch Godot**
2. **Click "New Project"**
3. **Set Project Name**: "Asteroid Shooter"
4. **Set Project Path**: Choose a location
5. **Renderer**: Choose "Forward+" (best performance) or "Mobile" (compatibility)
6. **Click "Create & Edit"**
7. **Copy all files** from this repository into the new project folder

---

## File Import Checklist

Ensure your project has this structure:

```
asteroid-shooter/
├── project.godot (created by Godot)
├── scenes/
│   ├── Main.tscn (create in Godot)
│   ├── Player.tscn (create in Godot)
│   ├── Bullet.tscn (create in Godot)
│   ├── Asteroid.tscn (create in Godot)
│   └── Explosion.tscn (create in Godot)
├── scripts/
│   ├── Player.gd ✓
│   ├── Bullet.gd ✓
│   ├── Asteroid.gd ✓
│   ├── Explosion.gd ✓
│   └── GameManager.gd ✓
├── ui/ (scenes built within Main.tscn)
└── assets/ (optional: for future sounds/textures)
```

**✓ = Files included in this repository**
**Scenes must be created following SCENE_SETUP.md**

---

## Building the Scenes

Follow these steps in order (detailed instructions in `SCENE_SETUP.md`):

### 1. Configure Input Map (First!)

**Project → Project Settings → Input Map**

Add these actions with keys:
- `move_left`: A, Left Arrow
- `move_right`: D, Right Arrow
- `move_up`: W, Up Arrow
- `shoot`: Space

### 2. Create Scenes in This Order

1. **Explosion.tscn**
   - Node2D → Attach `Explosion.gd` → Save
   
2. **Bullet.tscn**
   - Area2D → Add Polygon2D (visual) → Add CollisionShape2D
   - Attach `Bullet.gd` → Save
   
3. **Asteroid.tscn**
   - RigidBody2D → Add Polygon2D → Add CollisionShape2D
   - Attach `Asteroid.gd` → Set Gravity Scale = 0 → Save
   
4. **Player.tscn**
   - CharacterBody2D → Add Polygon2D (triangle) → Add CollisionShape2D
   - Add Marker2D (Muzzle) → Add Timer (ShootTimer)
   - Attach `Player.gd` → Assign Bullet Scene export → Save
   
5. **Main.tscn**
   - Node2D → Add GameManager (Node) with Timer
   - Add HUD (CanvasLayer) with ScoreLabel
   - Add UI (CanvasLayer) with StartMenu and GameOver
   - Attach `GameManager.gd` → Assign Player/Asteroid Scene exports
   - Connect button signals → Save

**See SCENE_SETUP.md for complete node hierarchies and properties**

---

## Setting the Main Scene

After creating all scenes:

1. **Project → Project Settings**
2. **Application → Run → Main Scene**
3. **Click folder icon** → Select `res://scenes/Main.tscn`
4. **Click "Close"**

Alternatively:
- Right-click `Main.tscn` in FileSystem
- Select **"Set as Main Scene"**

---

## Running the Game

### Play the Game

**Method 1: Main Menu**
- Press **F5** (or click ▶️ "Play" button in top-right)
- First time: Will prompt to select Main Scene

**Method 2: Current Scene**
- Press **F6** (or click 🎬 "Play Scene" button)
- Tests currently open scene

**Method 3: Custom Scene**
- Press **Shift+F5** → Select scene to run

### Stop the Game

- Press **F8** or click ⏹️ "Stop" button

---

## Testing Checklist

Verify everything works:

### Start Menu
- [ ] "ASTEROID SHOOTER" title displays
- [ ] "START GAME" button appears
- [ ] Clicking button starts game

### Gameplay
- [ ] Player ship appears at center
- [ ] Arrow keys/WASD rotate ship
- [ ] W/Up thrusts forward
- [ ] Space fires bullets
- [ ] Asteroids spawn from edges
- [ ] Bullets destroy asteroids
- [ ] Asteroids split into smaller pieces
- [ ] Score increases when destroying asteroids
- [ ] Score displays in top-left
- [ ] Ship wraps around screen edges
- [ ] Asteroids wrap around screen edges

### Game Over
- [ ] Colliding with asteroid kills player
- [ ] Explosion effect plays
- [ ] Game Over screen appears after delay
- [ ] Final score displays
- [ ] High score displays
- [ ] "RESTART" button appears
- [ ] Clicking restart starts new game

### Difficulty
- [ ] More asteroids spawn over time
- [ ] Score threshold increases difficulty

---

## Troubleshooting

### "Script error: Parse error"
- **Cause**: Syntax error in GDScript
- **Fix**: Open script, check Output panel for line number, fix syntax

### "Invalid get index 'X' on base Nil"
- **Cause**: Node path incorrect or node doesn't exist
- **Fix**: Check node names match exactly (case-sensitive), verify node hierarchy

### Player doesn't move
- **Cause**: Input actions not configured
- **Fix**: Project Settings → Input Map → Add move_left, move_right, move_up, shoot

### Bullets don't spawn
- **Cause**: Bullet scene not assigned to Player
- **Fix**: Select Player node → Inspector → Bullet Scene → Load Bullet.tscn

### Asteroids don't spawn
- **Cause**: Asteroid scene not assigned to GameManager
- **Fix**: Select GameManager → Inspector → Assign Asteroid.tscn and Player.tscn

### Collisions don't work
- **Cause**: Collision shapes missing or layers misconfigured
- **Fix**: 
  - Ensure all physics bodies have CollisionShape2D children
  - Check collision layers and masks are enabled

### UI doesn't show
- **Cause**: CanvasLayer issue or visibility settings
- **Fix**: 
  - Ensure UI nodes are children of CanvasLayer
  - Check visible property is true for StartMenu
  - Verify HUD is child of CanvasLayer

### "Scene not found" errors
- **Cause**: Scene paths incorrect or scenes not saved
- **Fix**: 
  - Save all scenes (Ctrl+S)
  - Use `res://` paths (e.g., `res://scenes/Bullet.tscn`)
  - Check spelling of scene filenames

### Game runs but looks wrong
- **Cause**: Node positions, scales, or properties incorrect
- **Fix**: Review SCENE_SETUP.md and UI_DESIGN.md for correct values

---

## Development Workflow

### Making Changes

1. **Edit scenes** in Scene dock
2. **Edit scripts** in Script editor (bottom panel)
3. **Save frequently** (Ctrl+S)
4. **Test often** (F5)
5. **Check Output panel** for errors

### Best Practices

- **Save before testing**: Unsaved changes won't run
- **Use print()**: Debug by printing to Output console
  ```gdscript
  print("Player position: ", position)
  ```
- **Test incrementally**: Test each scene individually with F6
- **Use breakpoints**: Click left of line number to pause execution
- **Read error messages**: Output panel shows exact line numbers

---

## Project Settings (Optional Tweaks)

### Display Settings

**Project → Project Settings → Display → Window**

- **Size → Viewport Width**: `1280` (default)
- **Size → Viewport Height**: `720` (default)
- **Size → Mode**: `Windowed`, `Fullscreen`, or `Maximized`
- **Stretch → Mode**: `canvas_items` (scales content)
- **Stretch → Aspect**: `keep` (maintains ratio)

### Performance Settings

**Project → Project Settings → Rendering**

- **Renderer**: Forward+ (best) or Mobile (compatible)
- **VSync Mode**: Enabled (smooth) or Disabled (faster)
- **Max FPS**: 0 (unlimited) or 60 (capped)

---

## Exporting the Game (Optional)

To create a standalone executable:

1. **Project → Export**
2. **Add export preset** (Windows, macOS, Linux, Web)
3. **Download export templates** (if first time)
4. **Configure settings** (name, icon, etc.)
5. **Click "Export Project"**
6. **Choose destination** → Save

---

## Next Steps

### Enhancements You Can Add

- **Sound Effects**: Add AudioStreamPlayer nodes for shoot, explosion, hit sounds
- **Music**: Background music on Main scene
- **Particles**: Use GPUParticles2D for better explosions
- **Power-ups**: Add collectibles for shields, rapid fire, etc.
- **Lives System**: Multiple lives before game over
- **Levels**: Different asteroid patterns or enemy types
- **Pause Menu**: Pause game with ESC key
- **Screenshake**: Camera shake on impacts
- **Parallax Background**: Scrolling starfield

### Learning Resources

- **Godot Docs**: https://docs.godotengine.org/en/stable/
- **GDScript Guide**: https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/
- **Godot Tutorials**: https://www.youtube.com/c/GodotEngineOfficial

---

## Support

If you encounter issues:

1. Check **Output panel** (bottom) for error messages
2. Review **SCENE_SETUP.md** for correct node hierarchies
3. Verify **Input Map** is configured
4. Ensure all **PackedScene exports** are assigned
5. Check **Godot version** is 4.0+ (not 3.x)

---

You're now ready to build and run the complete Asteroid Shooter game! 🚀

# Scene Setup Instructions for Godot 4.x

This document provides complete node hierarchies and setup instructions for all scenes.

## Table of Contents
1. [Main Scene (Main.tscn)](#main-scene)
2. [Player Scene (Player.tscn)](#player-scene)
3. [Bullet Scene (Bullet.tscn)](#bullet-scene)
4. [Asteroid Scene (Asteroid.tscn)](#asteroid-scene)
5. [Explosion Scene (Explosion.tscn)](#explosion-scene)
6. [Input Map Configuration](#input-map-configuration)

---

## Main Scene (Main.tscn)

**Purpose**: Root scene containing the game world, UI, and game manager.

### Node Hierarchy
```
Main (Node2D)
├── GameManager (Node)
│   └── SpawnTimer (Timer)
├── HUD (CanvasLayer)
│   └── ScoreLabel (Label)
└── UI (CanvasLayer)
    ├── StartMenu (Control)
    │   ├── ColorRect (ColorRect) - Background
    │   ├── VBoxContainer (VBoxContainer)
    │   │   ├── TitleLabel (Label)
    │   │   └── StartButton (Button)
    └── GameOver (Control)
        ├── ColorRect (ColorRect) - Background
        └── VBoxContainer (VBoxContainer)
            ├── GameOverLabel (Label)
            ├── ScoreLabel (Label)
            ├── HighScoreLabel (Label)
            └── RestartButton (Button)
```

### Setup Steps

1. **Create Main Node**
   - Right-click in Scene dock → "New Node"
   - Search for "Node2D" → Click "Create"
   - Rename to "Main"
   - Save scene as `res://scenes/Main.tscn`

2. **Add GameManager**
   - Select Main → Add Child Node → "Node"
   - Rename to "GameManager"
   - Attach script: `res://scripts/GameManager.gd`
   - In Inspector, set exported variables:
     - **Asteroid Scene**: Load `res://scenes/Asteroid.tscn`
     - **Player Scene**: Load `res://scenes/Player.tscn`
   - Add child Timer node named "SpawnTimer"

3. **Add HUD (CanvasLayer)**
   - Select Main → Add Child Node → "CanvasLayer"
   - Rename to "HUD"
   - Add child Label node named "ScoreLabel"
   - Configure ScoreLabel:
     - Position: `(20, 20)`
     - Text: "Score: 0"
     - Theme Override → Font Size: 32
     - Add Theme Overrides → Colors → Font Outline Color: Black
     - Add Theme Overrides → Constants → Outline Size: 3

4. **Add UI (CanvasLayer)**
   - Select Main → Add Child Node → "CanvasLayer"
   - Rename to "UI"
   - This will contain StartMenu and GameOver screens

5. **Add StartMenu (Control)**
   - Select UI → Add Child Node → "Control"
   - Rename to "StartMenu"
   - In Inspector → Layout → Anchors Preset: "Full Rect"
   - Add child ColorRect:
     - Name: "ColorRect"
     - Anchors Preset: "Full Rect"
     - Color: `rgba(0, 0, 0, 0.8)` (semi-transparent black)
   - Add child VBoxContainer:
     - Anchors Preset: "Center"
     - Custom Minimum Size: `(400, 300)`
     - Theme Override → Constants → Separation: 20
   - Add Label to VBoxContainer:
     - Name: "TitleLabel"
     - Text: "ASTEROID SHOOTER"
     - Horizontal Alignment: Center
     - Theme Override → Font Size: 48
   - Add Button to VBoxContainer:
     - Name: "StartButton"
     - Text: "START GAME"
     - Custom Minimum Size: `(200, 60)`
     - Connect "pressed" signal to GameManager script:
       ```gdscript
       func _on_start_button_pressed():
           start_game()
       ```

6. **Add GameOver (Control)**
   - Similar structure to StartMenu
   - Set initially to `visible = false` in Inspector
   - Labels: "GAME OVER", "Score: 0", "High Score: 0"
   - Button: "RESTART"
   - Connect button to GameManager's `start_game()`

---

## Player Scene (Player.tscn)

**Purpose**: Player-controlled spaceship with physics and shooting.

### Node Hierarchy
```
Player (CharacterBody2D)
├── Sprite2D (Polygon2D) - Visual representation
├── CollisionShape2D (CollisionShape2D) - Hit detection
├── Muzzle (Marker2D) - Bullet spawn point
└── ShootTimer (Timer) - Shoot cooldown
```

### Setup Steps

1. **Create Player Node**
   - New Scene → Other Node → "CharacterBody2D"
   - Rename to "Player"
   - Attach script: `res://scripts/Player.gd`
   - Save scene as `res://scenes/Player.tscn`

2. **Add Visual (Polygon2D)**
   - Add child Polygon2D node
   - Rename to "Sprite2D"
   - In Inspector → Polygon:
     - Click "Edit Polygon" button
     - Create triangle shape pointing up:
       - Point 1: `(0, -20)`
       - Point 2: `(-15, 20)`
       - Point 3: `(15, 20)`
   - Color: White or your preferred color

3. **Add CollisionShape2D**
   - Add child CollisionShape2D
   - In Inspector → Shape: Select "New ConvexPolygonShape2D"
   - Click on shape → Edit points to match visual triangle
   - Or use CircleShape2D with radius ~15 for simplicity

4. **Add Muzzle (Marker2D)**
   - Add child Marker2D
   - Rename to "Muzzle"
   - Position: `(0, -25)` (front of ship)
   - This marks where bullets spawn

5. **Add ShootTimer**
   - Add child Timer node
   - Name: "ShootTimer"
   - One Shot: Enabled

6. **Configure Player Script Export Variables**
   - Select Player node
   - In Inspector, find "Script Variables" section:
     - **Bullet Scene**: Load `res://scenes/Bullet.tscn`
     - **Rotation Speed**: 200
     - **Thrust Power**: 500
     - **Max Speed**: 400
     - **Friction**: 0.98
     - **Shoot Cooldown**: 0.25

7. **Connect Collision Signal**
   - Select Player node
   - Node dock → Signals tab
   - Double-click "body_entered"
   - Connect to Player script's `_on_body_entered` method

---

## Bullet Scene (Bullet.tscn)

**Purpose**: Projectile fired by the player.

### Node Hierarchy
```
Bullet (Area2D)
├── Sprite2D (Polygon2D) - Visual representation
└── CollisionShape2D (CollisionShape2D)
```

### Setup Steps

1. **Create Bullet Node**
   - New Scene → Other Node → "Area2D"
   - Rename to "Bullet"
   - Attach script: `res://scripts/Bullet.gd`
   - Save scene as `res://scenes/Bullet.tscn`

2. **Add Visual (Polygon2D)**
   - Add child Polygon2D
   - Rename to "Sprite2D"
   - Create small elongated rectangle:
     - Point 1: `(-2, -8)`
     - Point 2: `(2, -8)`
     - Point 3: `(2, 8)`
     - Point 4: `(-2, 8)`
   - Color: Yellow or bright color

3. **Add CollisionShape2D**
   - Add child CollisionShape2D
   - Shape: "New CapsuleShape2D"
   - Radius: 2
   - Height: 16
   - Rotation: 0° (vertical)

4. **Configure Area2D**
   - Select Bullet node
   - Inspector → Collision:
     - Layer: Keep Layer 1 enabled
     - Mask: Enable Layer 1 (to detect asteroids)

---

## Asteroid Scene (Asteroid.tscn)

**Purpose**: Enemy asteroid that player must avoid/destroy.

### Node Hierarchy
```
Asteroid (RigidBody2D)
├── Sprite2D (Polygon2D) - Visual representation
└── CollisionShape2D (CollisionShape2D)
```

### Setup Steps

1. **Create Asteroid Node**
   - New Scene → Other Node → "RigidBody2D"
   - Rename to "Asteroid"
   - Attach script: `res://scripts/Asteroid.gd`
   - Save scene as `res://scenes/Asteroid.tscn`

2. **Configure RigidBody2D**
   - Select Asteroid node
   - Inspector:
     - Gravity Scale: 0 (no gravity in space)
     - Linear Damp: 0 (no air resistance)
     - Angular Damp: 0
     - Lock Rotation: Disabled (allow spinning)

3. **Add Visual (Polygon2D)**
   - Add child Polygon2D
   - Rename to "Sprite2D"
   - Create irregular rock shape (8+ points):
     - Example points for roughly circular, jagged shape:
       - `(0, -30)`, `(20, -20)`, `(30, 0)`, `(25, 20)`
       - `(10, 30)`, `(-10, 25)`, `(-28, 10)`, `(-25, -15)`
   - Color: Gray or brown

4. **Add CollisionShape2D**
   - Add child CollisionShape2D
   - Shape: "New CircleShape2D"
   - Radius: 30 (adjust to match visual size)

5. **Configure Script Variables**
   - Size: LARGE (default)
   - Base Speed: 100
   - Rotation Speed: 50

---

## Explosion Scene (Explosion.tscn)

**Purpose**: Visual effect when objects are destroyed.

### Node Hierarchy
```
Explosion (Node2D)
```

### Setup Steps

1. **Create Explosion Node**
   - New Scene → Other Node → "Node2D"
   - Rename to "Explosion"
   - Attach script: `res://scripts/Explosion.gd`
   - Save scene as `res://scenes/Explosion.tscn`

2. **Configure Script Variables**
   - Duration: 0.5
   - Particle Count: 12
   - Particle Speed: 150
   - Particle Size: 4

**Note**: The explosion effect is entirely code-generated using Line2D nodes created at runtime.

---

## Input Map Configuration

You must configure input actions in Godot's Project Settings.

### Steps to Add Input Actions

1. **Open Project Settings**
   - Menu: Project → Project Settings
   - Click "Input Map" tab

2. **Add These Actions**:

   **move_left**
   - Click "Add New Action"
   - Type "move_left" → Press Enter
   - Click "+" button next to move_left
   - Press "A" key → Click OK
   - Click "+" again → Press "Left Arrow" → Click OK

   **move_right**
   - Action: "move_right"
   - Keys: "D", "Right Arrow"

   **move_up**
   - Action: "move_up"
   - Keys: "W", "Up Arrow"

   **shoot**
   - Action: "shoot"
   - Keys: "Space"

3. **Default Actions**
   - `ui_cancel` (ESC) - already exists for pause/menu
   - `ui_accept` (Enter) - already exists for start/restart

---

## Scene Connections Summary

### Groups Used
- **player**: Player ship (for easy reference)
- **asteroid**: All asteroids (for collision detection)
- **bullet**: All bullets (for cleanup)
- **game_manager**: GameManager node (for game-wide function calls)

### Signals Used
- **Player → body_entered**: Detect collision with asteroids
- **Bullet → body_entered**: Detect collision with asteroids
- **StartButton → pressed**: Start game
- **RestartButton → pressed**: Restart game
- **ShootTimer → timeout**: Re-enable shooting
- **SpawnTimer → timeout**: Spawn new asteroids

### Scene References (PackedScene exports)
- **GameManager**: References Asteroid.tscn and Player.tscn
- **Player**: References Bullet.tscn

---

## Building the Scenes in Order

Recommended order to avoid missing references:

1. **Explosion.tscn** (no dependencies)
2. **Bullet.tscn** (no dependencies)
3. **Asteroid.tscn** (references Explosion via preload)
4. **Player.tscn** (references Bullet and Explosion)
5. **Main.tscn** (references all others via GameManager)

---

## Troubleshooting Tips

- **"Invalid get index" errors**: Check node names match exactly (case-sensitive)
- **Collisions not working**: Verify collision layers/masks are set correctly
- **Bullets/asteroids not appearing**: Check PackedScene references are assigned
- **Player not moving**: Verify input actions are configured in Project Settings
- **Objects not wrapping**: Ensure scripts are attached and running

---

This completes the scene setup documentation. Follow these instructions step-by-step in Godot 4.x to build the complete game.

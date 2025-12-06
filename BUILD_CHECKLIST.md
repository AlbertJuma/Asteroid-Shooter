# Complete Build Checklist

Use this checklist to build the Asteroid Shooter game from scratch in Godot 4.x.

---

## ✅ Prerequisites

- [ ] Godot 4.0+ installed
- [ ] All script files (.gd) are in the `scripts/` folder
- [ ] Project opened in Godot

---

## 🎯 Step 1: Configure Input Actions

**Project → Project Settings → Input Map**

- [ ] Add action `move_left` with keys: **A**, **Left Arrow**
- [ ] Add action `move_right` with keys: **D**, **Right Arrow**  
- [ ] Add action `move_up` with keys: **W**, **Up Arrow**
- [ ] Add action `shoot` with key: **Space**
- [ ] Verify `ui_cancel` (ESC) exists
- [ ] Verify `ui_accept` (Enter) exists
- [ ] Click **Close** to save

---

## 🔨 Step 2: Build Explosion Scene

**Scene → New Scene → Other Node → Node2D**

### Hierarchy
```
Explosion (Node2D)
```

### Configuration
- [ ] Select Explosion node
- [ ] Click script icon → Load Script → `res://scripts/Explosion.gd`
- [ ] Verify script attached (script icon turns white)

### Save
- [ ] **Scene → Save Scene**
- [ ] Navigate to `scenes/` folder
- [ ] Name: `Explosion.tscn`
- [ ] Click **Save**

---

## 🔨 Step 3: Build Bullet Scene

**Scene → New Scene → Other Node → Area2D**

### Hierarchy
```
Bullet (Area2D)
├── Sprite2D (Polygon2D)
└── CollisionShape2D
```

### Build Steps

1. **Create Bullet Node**
   - [ ] Rename to `Bullet`
   - [ ] Attach script: `res://scripts/Bullet.gd`

2. **Add Visual (Polygon2D)**
   - [ ] Add child node: **Polygon2D**
   - [ ] Rename to `Sprite2D`
   - [ ] Select Sprite2D → Inspector → **Polygon**
   - [ ] Click **Edit Polygon** toolbar button (top)
   - [ ] Add 4 points to create small rectangle:
     - Click at: `(-2, -8)`
     - Click at: `(2, -8)`
     - Click at: `(2, 8)`
     - Click at: `(-2, 8)`
   - [ ] Press ESC to finish editing
   - [ ] Inspector → **Color**: Choose **Yellow** or bright color

3. **Add Collision**
   - [ ] Select Bullet → Add child node: **CollisionShape2D**
   - [ ] Inspector → **Shape**: Click dropdown → **New CapsuleShape2D**
   - [ ] Click the capsule shape to edit
   - [ ] Inspector → **Radius**: `2`
   - [ ] Inspector → **Height**: `16`

### Save
- [ ] **Scene → Save Scene** as `scenes/Bullet.tscn`

---

## 🔨 Step 4: Build Asteroid Scene

**Scene → New Scene → Other Node → RigidBody2D**

### Hierarchy
```
Asteroid (RigidBody2D)
├── Sprite2D (Polygon2D)
└── CollisionShape2D
```

### Build Steps

1. **Create Asteroid Node**
   - [ ] Rename to `Asteroid`
   - [ ] Inspector → **Gravity Scale**: `0` (important!)
   - [ ] Inspector → **Linear Damp**: `0`
   - [ ] Inspector → **Angular Damp**: `0`
   - [ ] Attach script: `res://scripts/Asteroid.gd`

2. **Add Visual (Polygon2D)**
   - [ ] Add child node: **Polygon2D**
   - [ ] Rename to `Sprite2D`
   - [ ] Select Sprite2D → Inspector → **Polygon**
   - [ ] Click **Edit Polygon** button
   - [ ] Create jagged rock shape (8+ points in rough circle):
     - Example points: `(0, -30)`, `(20, -20)`, `(30, 0)`, `(25, 20)`, `(10, 30)`, `(-10, 25)`, `(-28, 10)`, `(-25, -15)`
   - [ ] Press ESC when done
   - [ ] Inspector → **Color**: Choose **Gray** `(150, 140, 130)`

3. **Add Collision**
   - [ ] Select Asteroid → Add child node: **CollisionShape2D**
   - [ ] Inspector → **Shape**: **New CircleShape2D**
   - [ ] Click circle to edit
   - [ ] Inspector → **Radius**: `30`

### Save
- [ ] **Scene → Save Scene** as `scenes/Asteroid.tscn`

---

## 🔨 Step 5: Build Player Scene

**Scene → New Scene → Other Node → CharacterBody2D**

### Hierarchy
```
Player (CharacterBody2D)
├── Sprite2D (Polygon2D)
├── CollisionShape2D
├── Muzzle (Marker2D)
└── ShootTimer (Timer)
```

### Build Steps

1. **Create Player Node**
   - [ ] Rename to `Player`
   - [ ] Attach script: `res://scripts/Player.gd`

2. **Add Visual (Polygon2D)**
   - [ ] Add child node: **Polygon2D**
   - [ ] Rename to `Sprite2D`
   - [ ] Select Sprite2D → Inspector → **Polygon**
   - [ ] Click **Edit Polygon** button
   - [ ] Create triangle pointing up (3 points):
     - Click at: `(0, -20)` (top point)
     - Click at: `(-15, 20)` (bottom-left)
     - Click at: `(15, 20)` (bottom-right)
   - [ ] Press ESC when done
   - [ ] Inspector → **Color**: **White** or **Light Blue**

3. **Add Collision**
   - [ ] Select Player → Add child node: **CollisionShape2D**
   - [ ] Inspector → **Shape**: **New CircleShape2D**
   - [ ] Click circle to edit
   - [ ] Inspector → **Radius**: `15`

4. **Add Muzzle Point**
   - [ ] Select Player → Add child node: **Marker2D**
   - [ ] Rename to `Muzzle` (exact spelling!)
   - [ ] Inspector → **Position**: `(0, -25)` (front of ship)

5. **Add Shoot Timer**
   - [ ] Select Player → Add child node: **Timer**
   - [ ] Rename to `ShootTimer` (exact spelling!)
   - [ ] Inspector → **One Shot**: **Enabled** ✓

6. **Configure Script Exports**
   - [ ] Select Player node
   - [ ] Inspector → Scroll to **Script Variables** section
   - [ ] **Bullet Scene**: Click folder → Select `res://scenes/Bullet.tscn`
   - [ ] Verify other values: rotation_speed=200, thrust_power=500, etc.

7. **Connect Collision Signal**
   - [ ] Select Player node
   - [ ] Node dock (right side) → **Signals** tab
   - [ ] Double-click **body_entered(body: Node2D)**
   - [ ] Connection window → **Receiver Method**: `_on_body_entered`
   - [ ] Click **Connect**

### Save
- [ ] **Scene → Save Scene** as `scenes/Player.tscn`

---

## 🔨 Step 6: Build Main Scene

**Scene → New Scene → Other Node → Node2D**

### Hierarchy
```
Main (Node2D)
├── GameManager (Node)
│   └── SpawnTimer (Timer)
├── HUD (CanvasLayer)
│   └── ScoreLabel (Label)
└── UI (CanvasLayer)
    ├── StartMenu (Control)
    │   ├── ColorRect
    │   └── VBoxContainer
    │       ├── TitleLabel (Label)
    │       └── StartButton (Button)
    └── GameOver (Control)
        ├── ColorRect
        └── VBoxContainer
            ├── GameOverLabel (Label)
            ├── ScoreLabel (Label)
            ├── HighScoreLabel (Label)
            └── RestartButton (Button)
```

### Part A: GameManager

1. **Create Main Node**
   - [ ] Rename to `Main`

2. **Add GameManager**
   - [ ] Select Main → Add child node: **Node**
   - [ ] Rename to `GameManager`
   - [ ] Attach script: `res://scripts/GameManager.gd`

3. **Add SpawnTimer**
   - [ ] Select GameManager → Add child node: **Timer**
   - [ ] Rename to `SpawnTimer` (exact spelling!)
   - [ ] Inspector → **Wait Time**: `5.0`
   - [ ] Inspector → **Autostart**: **Disabled** (leave unchecked)

4. **Configure GameManager Exports**
   - [ ] Select GameManager node
   - [ ] Inspector → **Script Variables**
   - [ ] **Asteroid Scene**: Load `res://scenes/Asteroid.tscn`
   - [ ] **Player Scene**: Load `res://scenes/Player.tscn`

### Part B: HUD

1. **Add HUD Layer**
   - [ ] Select Main → Add child node: **CanvasLayer**
   - [ ] Rename to `HUD`

2. **Add Score Label**
   - [ ] Select HUD → Add child node: **Label**
   - [ ] Rename to `ScoreLabel` (exact spelling!)
   - [ ] Inspector → **Text**: `"Score: 0"`
   - [ ] Inspector → **Position**: `(20, 20)`
   - [ ] Theme Overrides → **Font Size**: `32`
   - [ ] Theme Overrides → Colors → **Font Color**: **White**
   - [ ] Theme Overrides → Colors → **Font Outline Color**: **Black**
   - [ ] Theme Overrides → Constants → **Outline Size**: `3`

### Part C: UI Layer & Start Menu

1. **Add UI Layer**
   - [ ] Select Main → Add child node: **CanvasLayer**
   - [ ] Rename to `UI`

2. **Add StartMenu**
   - [ ] Select UI → Add child node: **Control**
   - [ ] Rename to `StartMenu`
   - [ ] Inspector → Layout → **Anchors Preset**: Click **Full Rect**

3. **Add Background**
   - [ ] Select StartMenu → Add child node: **ColorRect**
   - [ ] Inspector → Layout → **Anchors Preset**: **Full Rect**
   - [ ] Inspector → **Color**: `rgba(0, 0, 0, 0.8)` (black, alpha 0.8)

4. **Add Container**
   - [ ] Select StartMenu → Add child node: **VBoxContainer**
   - [ ] Inspector → Layout → **Anchors Preset**: **Center**
   - [ ] Inspector → **Custom Minimum Size**: `(400, 300)`
   - [ ] Theme Overrides → Constants → **Separation**: `20`

5. **Add Title**
   - [ ] Select VBoxContainer → Add child node: **Label**
   - [ ] Rename to `TitleLabel`
   - [ ] Inspector → **Text**: `"ASTEROID SHOOTER"`
   - [ ] Inspector → **Horizontal Alignment**: **Center**
   - [ ] Theme Overrides → **Font Size**: `48`
   - [ ] Theme Overrides → Colors → **Font Color**: **White**
   - [ ] Theme Overrides → Colors → **Font Outline Color**: **Black**
   - [ ] Theme Overrides → Constants → **Outline Size**: `4`

6. **Add Start Button**
   - [ ] Select VBoxContainer → Add child node: **Button**
   - [ ] Rename to `StartButton`
   - [ ] Inspector → **Text**: `"START GAME"`
   - [ ] Inspector → **Custom Minimum Size**: `(200, 60)`
   - [ ] Node dock → **Signals** tab
   - [ ] Double-click **pressed()**
   - [ ] Connect to: **GameManager** node
   - [ ] Method: Type `_on_start_button_pressed`
   - [ ] Click **Connect**

7. **Add Connection in GameManager Script**
   - [ ] Open `scripts/GameManager.gd` in editor
   - [ ] Add this function at the bottom:
   ```gdscript
   func _on_start_button_pressed():
       start_game()
   ```

### Part D: Game Over Screen

1. **Add GameOver**
   - [ ] Select UI → Add child node: **Control**
   - [ ] Rename to `GameOver`
   - [ ] Inspector → Layout → **Anchors Preset**: **Full Rect**
   - [ ] Inspector → **Visible**: **Disabled** ✗ (unchecked!)

2. **Add Background**
   - [ ] Select GameOver → Add child node: **ColorRect**
   - [ ] Inspector → Layout → **Anchors Preset**: **Full Rect**
   - [ ] Inspector → **Color**: `rgba(0, 0, 0, 0.8)`

3. **Add Container**
   - [ ] Select GameOver → Add child node: **VBoxContainer**
   - [ ] Inspector → Layout → **Anchors Preset**: **Center**
   - [ ] Inspector → **Custom Minimum Size**: `(400, 400)`
   - [ ] Theme Overrides → Constants → **Separation**: `15`

4. **Add Game Over Label**
   - [ ] Select VBoxContainer → Add child node: **Label**
   - [ ] Rename to `GameOverLabel`
   - [ ] Inspector → **Text**: `"GAME OVER"`
   - [ ] Inspector → **Horizontal Alignment**: **Center**
   - [ ] Theme Overrides → **Font Size**: `56`
   - [ ] Theme Overrides → Colors → **Font Color**: **Red** `(255, 80, 80)`
   - [ ] Theme Overrides → Colors → **Font Outline Color**: **Black**
   - [ ] Theme Overrides → Constants → **Outline Size**: `4`

5. **Add Score Label**
   - [ ] Select VBoxContainer → Add child node: **Label**
   - [ ] Rename to `ScoreLabel`
   - [ ] Inspector → **Text**: `"Score: 0"`
   - [ ] Inspector → **Horizontal Alignment**: **Center**
   - [ ] Theme Overrides → **Font Size**: `32`
   - [ ] Theme Overrides → Colors → **Font Color**: **White**
   - [ ] Theme Overrides → Constants → **Outline Size**: `3`

6. **Add High Score Label**
   - [ ] Select VBoxContainer → Add child node: **Label**
   - [ ] Rename to `HighScoreLabel`
   - [ ] Inspector → **Text**: `"High Score: 0"`
   - [ ] Inspector → **Horizontal Alignment**: **Center**
   - [ ] Theme Overrides → **Font Size**: `28`
   - [ ] Theme Overrides → Colors → **Font Color**: **Yellow** `(255, 255, 100)`
   - [ ] Theme Overrides → Constants → **Outline Size**: `3`

7. **Add Restart Button**
   - [ ] Select VBoxContainer → Add child node: **Button**
   - [ ] Rename to `RestartButton`
   - [ ] Inspector → **Text**: `"RESTART"`
   - [ ] Inspector → **Custom Minimum Size**: `(200, 60)`
   - [ ] Node dock → **Signals** tab
   - [ ] Double-click **pressed()**
   - [ ] Connect to: **GameManager** node
   - [ ] Method: Type `_on_restart_button_pressed`
   - [ ] Click **Connect**

8. **Add Restart Function**
   - [ ] Open `scripts/GameManager.gd`
   - [ ] Add function:
   ```gdscript
   func _on_restart_button_pressed():
       start_game()
   ```

### Save Main Scene
- [ ] **Scene → Save Scene** as `scenes/Main.tscn`

---

## 🎯 Step 7: Set Main Scene

**Project → Project Settings**

- [ ] Click **Application** section
- [ ] Click **Run** subsection
- [ ] **Main Scene**: Click folder → Select `res://scenes/Main.tscn`
- [ ] Click **Close**

**Or use right-click method:**
- [ ] Right-click `Main.tscn` in FileSystem dock
- [ ] Select **"Set as Main Scene"**

---

## 🚀 Step 8: Test the Game

### First Run
- [ ] Press **F5** (or click ▶️ Play)
- [ ] If prompted, select `Main.tscn` as main scene

### Test Checklist
- [ ] Start menu appears with title and button
- [ ] Click "START GAME" → Game starts
- [ ] Player ship appears at center
- [ ] **A/D** or **Arrow Keys** rotate ship
- [ ] **W/Up** thrusts forward
- [ ] **Space** fires bullets
- [ ] Asteroids spawn from edges
- [ ] Bullets destroy asteroids
- [ ] Large asteroids split into medium
- [ ] Medium asteroids split into small
- [ ] Small asteroids disappear when hit
- [ ] Score increases in top-left
- [ ] More asteroids spawn over time
- [ ] Colliding with asteroid ends game
- [ ] Explosion effect shows
- [ ] Game Over screen appears
- [ ] Shows final score and high score
- [ ] Click "RESTART" → New game starts

---

## ✅ Final Verification

### All Scenes Created
- [ ] `scenes/Explosion.tscn` exists
- [ ] `scenes/Bullet.tscn` exists
- [ ] `scenes/Asteroid.tscn` exists
- [ ] `scenes/Player.tscn` exists
- [ ] `scenes/Main.tscn` exists and set as main

### All Scripts Attached
- [ ] Explosion has `Explosion.gd`
- [ ] Bullet has `Bullet.gd`
- [ ] Asteroid has `Asteroid.gd`
- [ ] Player has `Player.gd`
- [ ] GameManager has `GameManager.gd`

### All Exports Assigned
- [ ] GameManager → Asteroid Scene assigned
- [ ] GameManager → Player Scene assigned
- [ ] Player → Bullet Scene assigned

### All Signals Connected
- [ ] Player → body_entered connected
- [ ] StartButton → pressed connected to GameManager
- [ ] RestartButton → pressed connected to GameManager

### Input Actions Configured
- [ ] `move_left` (A, Left)
- [ ] `move_right` (D, Right)
- [ ] `move_up` (W, Up)
- [ ] `shoot` (Space)

---

## 🎉 Congratulations!

You've successfully built the complete Asteroid Shooter game!

### What You Built
- ✅ Complete game with menu system
- ✅ Player movement and shooting
- ✅ Asteroid spawning and physics
- ✅ Collision detection
- ✅ Score tracking
- ✅ Progressive difficulty
- ✅ Visual effects
- ✅ Game over and restart

### Next Steps
- Play and test thoroughly
- Tweak values to your liking (see QUICK_REFERENCE.md)
- Add sound effects
- Add particle effects
- Create your own variations!

---

**Build Checklist v1.0** | Asteroid Shooter | Godot 4.x

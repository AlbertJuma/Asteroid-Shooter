# Asteroid Shooter

A classic arcade-style space shooter game built with **Godot 4.x**. Navigate your spaceship through an asteroid field, destroy asteroids to earn points, and survive as long as possible!

![Game Type](https://img.shields.io/badge/Game-Arcade%20Shooter-blue)
![Engine](https://img.shields.io/badge/Engine-Godot%204.x-478cbf)
![Language](https://img.shields.io/badge/Language-GDScript-355570)
![Status](https://img.shields.io/badge/Status-Complete-success)

---

## 📖 Game Overview

**Asteroid Shooter** is a classic arcade game where you control a triangular spaceship navigating through an asteroid field. Your objective is to survive as long as possible by destroying incoming asteroids while avoiding collisions.

### Controls
- **Arrow Keys / WASD**: Rotate ship left/right, thrust forward
- **SPACE**: Shoot bullets
- **ESC**: Pause/Return to menu
- **ENTER**: Start game / Restart after game over

### Objectives
- Destroy asteroids to earn points (Larger asteroids = fewer points, smaller = more points)
- Survive as long as possible without colliding with asteroids
- Beat your high score as difficulty increases
- Watch asteroids split into smaller pieces when destroyed

### Features
- ✨ Progressive difficulty (more asteroids spawn as score increases)
- 🎯 Score tracking with high score persistence
- 💥 Explosion effects when objects are destroyed
- 🔄 Screen wrapping (ship and asteroids wrap around edges)
- 📊 Clean, readable HUD
- 🎮 Simple, intuitive controls
- 🎨 Built entirely with Godot primitives (no external assets required)

---

## 🚀 Quick Start

### Prerequisites
- **Godot 4.0+** ([Download here](https://godotengine.org/download))
- No additional dependencies required!

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/AlbertJuma/asteroid-shooter.git
   cd asteroid-shooter
   ```

2. **Open in Godot**
   - Launch Godot Engine
   - Click "Import"
   - Navigate to the `asteroid-shooter` folder
   - Select `project.godot`
   - Click "Import & Edit"

3. **Set up the game** (First time only)
   - Follow the step-by-step instructions in **[SETUP_INSTRUCTIONS.md](SETUP_INSTRUCTIONS.md)**
   - Build the 5 required scenes following **[SCENE_SETUP.md](SCENE_SETUP.md)**
   - Configure input actions (takes 2 minutes)

4. **Run the game**
   - Press **F5** or click the ▶️ Play button
   - Enjoy!

---

## 📁 Project Structure

```
asteroid-shooter/
├── README.md                    # This file
├── GAME_OVERVIEW.md             # Detailed game description
├── SETUP_INSTRUCTIONS.md        # Complete setup guide
├── SCENE_SETUP.md               # Scene node hierarchies and configuration
├── UI_DESIGN.md                 # UI layout and styling guide
│
├── scenes/                      # Godot scene files (.tscn)
│   ├── Main.tscn               # Root game scene
│   ├── Player.tscn             # Player spaceship
│   ├── Bullet.tscn             # Bullet projectile
│   ├── Asteroid.tscn           # Asteroid enemy
│   └── Explosion.tscn          # Explosion effect
│
├── scripts/                     # GDScript files (.gd)
│   ├── GameManager.gd          # Game state and spawning logic
│   ├── Player.gd               # Player movement and shooting
│   ├── Bullet.gd               # Bullet behavior
│   ├── Asteroid.gd             # Asteroid movement and splitting
│   └── Explosion.gd            # Visual explosion effect
│
├── ui/                          # UI components (built within Main.tscn)
│   ├── StartMenu               # Title screen
│   ├── GameOver                # End game screen
│   └── HUD                     # In-game score display
│
└── assets/                      # Optional folder for future assets
```

---

## 📚 Documentation

All documentation is included in this repository:

| Document | Purpose |
|----------|---------|
| **[GAME_OVERVIEW.md](GAME_OVERVIEW.md)** | Game description, controls, and objectives |
| **[SETUP_INSTRUCTIONS.md](SETUP_INSTRUCTIONS.md)** | How to import, build, and run the game |
| **[SCENE_SETUP.md](SCENE_SETUP.md)** | Complete node hierarchies and configurations |
| **[UI_DESIGN.md](UI_DESIGN.md)** | UI layouts, styling, and responsive design |

### Quick Links
- 🎮 [Controls & Gameplay](GAME_OVERVIEW.md)
- 🛠️ [Setup Guide](SETUP_INSTRUCTIONS.md)
- 🏗️ [Scene Building](SCENE_SETUP.md)
- 🎨 [UI Design](UI_DESIGN.md)

---

## 🎮 How to Play

1. **Start Menu**: Click "START GAME" or press ENTER
2. **Movement**: 
   - Use **A/D** or **Arrow Keys** to rotate your ship
   - Press **W/Up Arrow** to thrust forward
3. **Shooting**: Press **SPACE** to fire bullets
4. **Objective**: Destroy asteroids without colliding with them
5. **Scoring**:
   - Large asteroids: **20 points** (split into medium)
   - Medium asteroids: **50 points** (split into small)
   - Small asteroids: **100 points** (destroyed completely)
6. **Difficulty**: Every 500 points, an additional asteroid spawns
7. **Game Over**: Collision with any asteroid ends the game
8. **Restart**: Click "RESTART" or press ENTER

---

## 🛠️ Technical Details

### Built With
- **Engine**: Godot 4.x
- **Language**: GDScript (Python-like syntax)
- **Graphics**: Godot primitives (Polygon2D, Line2D)
- **Physics**: Godot's built-in 2D physics engine

### Key Systems

#### Game Manager (`GameManager.gd`)
- State management (Menu, Playing, Game Over)
- Score tracking and difficulty scaling
- Asteroid spawning system
- Game object lifecycle

#### Player System (`Player.gd`)
- Physics-based movement with thrust and friction
- Rotation controls
- Shooting with cooldown
- Screen wrapping
- Collision detection

#### Asteroid System (`Asteroid.gd`)
- Three size variants (Large, Medium, Small)
- Splitting behavior when destroyed
- Random movement patterns
- Screen wrapping

#### Combat System (`Bullet.gd`)
- Fast-moving projectiles
- Collision detection with asteroids
- Auto-cleanup after lifetime

#### Visual Effects (`Explosion.gd`)
- Procedurally generated particle explosion
- Scales with object size
- Auto-cleanup

---

## 🎨 Customization

The game is designed to be easily customizable:

### Tweaking Difficulty
Edit `GameManager.gd`:
```gdscript
@export var base_asteroid_count: int = 3  # Starting asteroids
@export var difficulty_increase_score: int = 500  # Score for next asteroid
```

### Adjusting Player Physics
Edit `Player.gd`:
```gdscript
@export var rotation_speed: float = 200.0  # Degrees per second
@export var thrust_power: float = 500.0
@export var max_speed: float = 400.0
@export var friction: float = 0.98
```

### Changing Asteroid Behavior
Edit `Asteroid.gd`:
```gdscript
@export var base_speed: float = 100.0
@export var rotation_speed: float = 50.0
```

### Score Values
Edit `Asteroid.gd`:
```gdscript
const SCORE_VALUES = {
    AsteroidSize.LARGE: 20,
    AsteroidSize.MEDIUM: 50,
    AsteroidSize.SMALL: 100
}
```

---

## 🎓 Learning Resources

This project is beginner-friendly and well-commented. Great for learning:

- ✅ **Godot Scene System**: How to structure game objects
- ✅ **GDScript Basics**: Variables, functions, signals
- ✅ **2D Physics**: CharacterBody2D, RigidBody2D, Area2D
- ✅ **Game State Management**: FSM pattern
- ✅ **UI Design**: CanvasLayer, Control nodes
- ✅ **Input Handling**: Action maps and input polling
- ✅ **Collision Detection**: Layers, masks, and signals
- ✅ **Object Pooling**: Efficient spawning/despawning

### Recommended Next Steps

1. **Add Sound Effects**: Learn AudioStreamPlayer
2. **Particle Systems**: Upgrade explosions with GPUParticles2D
3. **Power-ups**: Create collectible items
4. **Save System**: Persistent high scores with JSON
5. **Menus**: Add pause menu and settings
6. **Mobile Support**: Touch controls for mobile devices

---

## 🤝 Contributing

Contributions are welcome! Feel free to:

- 🐛 Report bugs
- 💡 Suggest new features
- 🔧 Submit pull requests
- 📖 Improve documentation

---

## 📄 License

This project is open source and available under the MIT License.

---

## 🎮 Acknowledgments

- Inspired by the classic **Asteroids** arcade game (1979)
- Built with the amazing **Godot Engine**
- Designed for educational purposes and game development learning

---

## 📞 Support

If you encounter any issues:

1. Check the **[SETUP_INSTRUCTIONS.md](SETUP_INSTRUCTIONS.md)** troubleshooting section
2. Review the **[SCENE_SETUP.md](SCENE_SETUP.md)** for correct configurations
3. Open an issue on GitHub with:
   - Godot version
   - Error message (from Output panel)
   - Steps to reproduce

---

## 🌟 Show Your Support

If you found this project helpful:
- ⭐ Star this repository
- 🍴 Fork and build your own version
- 📣 Share with others learning Godot

---

**Happy Gaming!** 🚀🎮

*Built with ❤️ using Godot 4.x*
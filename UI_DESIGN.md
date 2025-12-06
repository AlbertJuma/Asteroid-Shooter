# UI Design Guide

This document provides detailed layouts and styling for all UI screens.

## UI Architecture

All UI is built using Godot's Control nodes and CanvasLayers. The game has three UI states:
1. **Start Menu** - Initial screen when launching the game
2. **HUD** - In-game score display
3. **Game Over** - End screen with score and restart option

---

## HUD (Heads-Up Display)

**Purpose**: Shows score during gameplay

### Layout Structure
```
HUD (CanvasLayer)
└── ScoreLabel (Label)
```

### Configuration

**ScoreLabel**:
- **Position**: `(20, 20)` (top-left corner)
- **Text**: "Score: 0"
- **Size Flags**: Shrink Begin (both H and V)
- **Theme Overrides**:
  - Font Size: `32`
  - Font Color: `White (255, 255, 255)`
  - Outline Size: `3`
  - Outline Color: `Black (0, 0, 0)`

### Visual Appearance
```
┌─────────────────────────────────┐
│ Score: 0                        │
│                                 │
│         [Game Area]             │
│                                 │
└─────────────────────────────────┘
```

---

## Start Menu

**Purpose**: Title screen with game title and start button

### Layout Structure
```
StartMenu (Control)
├── ColorRect (ColorRect) - Semi-transparent background
└── VBoxContainer (VBoxContainer) - Centered container
    ├── TitleLabel (Label)
    └── StartButton (Button)
```

### Configuration

**StartMenu (Control)**:
- **Anchors Preset**: Full Rect
- **Visible**: true (initially)

**ColorRect**:
- **Anchors Preset**: Full Rect
- **Color**: `rgba(0, 0, 0, 0.8)` - Semi-transparent black overlay
- **Purpose**: Darkens background, makes menu readable

**VBoxContainer**:
- **Anchors Preset**: Center
- **Custom Minimum Size**: `(400, 300)`
- **Position**: Auto-centered by anchor
- **Theme Overrides**:
  - Separation: `20` (space between children)
- **Alignment**: Center (both H and V)

**TitleLabel**:
- **Text**: "ASTEROID SHOOTER"
- **Horizontal Alignment**: Center
- **Vertical Alignment**: Center
- **Theme Overrides**:
  - Font Size: `48`
  - Font Color: `White`
  - Outline Size: `4`
  - Outline Color: `Black`
- **Autowrap Mode**: Off

**StartButton**:
- **Text**: "START GAME"
- **Custom Minimum Size**: `(200, 60)`
- **Theme Overrides** (optional):
  - Font Size: `24`
- **Focus Mode**: All (can be selected with keyboard/gamepad)

### Button Signal
Connect the `pressed` signal to GameManager:
```gdscript
# In GameManager.gd or connect via editor
func _on_start_button_pressed():
    start_game()
```

### Visual Appearance
```
┌─────────────────────────────────┐
│                                 │
│                                 │
│      ASTEROID SHOOTER           │
│                                 │
│      ┌───────────────┐          │
│      │  START GAME   │          │
│      └───────────────┘          │
│                                 │
│                                 │
└─────────────────────────────────┘
```

---

## Game Over Screen

**Purpose**: Display final score and offer restart

### Layout Structure
```
GameOver (Control)
├── ColorRect (ColorRect) - Semi-transparent background
└── VBoxContainer (VBoxContainer) - Centered container
    ├── GameOverLabel (Label)
    ├── ScoreLabel (Label)
    ├── HighScoreLabel (Label)
    └── RestartButton (Button)
```

### Configuration

**GameOver (Control)**:
- **Anchors Preset**: Full Rect
- **Visible**: false (initially hidden)

**ColorRect**:
- **Anchors Preset**: Full Rect
- **Color**: `rgba(0, 0, 0, 0.8)`

**VBoxContainer**:
- **Anchors Preset**: Center
- **Custom Minimum Size**: `(400, 400)`
- **Theme Overrides**:
  - Separation: `15`
- **Alignment**: Center

**GameOverLabel**:
- **Text**: "GAME OVER"
- **Horizontal Alignment**: Center
- **Theme Overrides**:
  - Font Size: `56`
  - Font Color: `Red (255, 80, 80)` or White
  - Outline Size: `4`
  - Outline Color: `Black`

**ScoreLabel**:
- **Text**: "Score: 0" (updated by GameManager)
- **Horizontal Alignment**: Center
- **Theme Overrides**:
  - Font Size: `32`
  - Font Color: `White`
  - Outline Size: `3`
  - Outline Color: `Black`

**HighScoreLabel**:
- **Text**: "High Score: 0" (updated by GameManager)
- **Horizontal Alignment**: Center
- **Theme Overrides**:
  - Font Size: `28`
  - Font Color: `Yellow (255, 255, 100)`
  - Outline Size: `3`
  - Outline Color: `Black`

**RestartButton**:
- **Text**: "RESTART"
- **Custom Minimum Size**: `(200, 60)`
- **Theme Overrides**:
  - Font Size: `24`

### Button Signal
Connect the `pressed` signal to GameManager:
```gdscript
func _on_restart_button_pressed():
    start_game()
```

### Visual Appearance
```
┌─────────────────────────────────┐
│                                 │
│       GAME OVER                 │
│                                 │
│       Score: 1250               │
│                                 │
│       High Score: 1250          │
│                                 │
│      ┌───────────────┐          │
│      │    RESTART    │          │
│      └───────────────┘          │
│                                 │
└─────────────────────────────────┘
```

---

## Color Palette Suggestions

### Default Theme
- **Background**: Black `(0, 0, 0)`
- **UI Overlay**: Dark Semi-transparent `rgba(0, 0, 0, 0.8)`
- **Primary Text**: White `(255, 255, 255)`
- **Score Text**: White with black outline
- **High Score**: Yellow/Gold `(255, 255, 100)`
- **Title**: White with black outline
- **Game Over**: Red-tinted white `(255, 80, 80)`

### Game Objects
- **Player Ship**: White or Light Blue `(100, 200, 255)`
- **Asteroids**: Gray/Brown `(150, 140, 130)`
- **Bullets**: Yellow/Orange `(255, 220, 100)`
- **Explosions**: Yellow-Orange gradient

---

## Responsive Design Notes

The UI is designed to work at various resolutions:

1. **Anchors**: Use "Full Rect" for backgrounds and "Center" for menus
2. **Minimum Sizes**: Set on containers to prevent shrinking too small
3. **CanvasLayer**: Keeps UI above game world regardless of camera
4. **Theme Overrides**: Use consistent font sizes that scale well

### Recommended Project Settings
- **Display > Window > Size > Viewport Width**: `1280`
- **Display > Window > Size > Viewport Height**: `720`
- **Display > Window > Size > Mode**: Windowed or Fullscreen
- **Display > Window > Stretch > Mode**: `canvas_items`
- **Display > Window > Stretch > Aspect**: `keep`

---

## Accessibility Considerations

- **High Contrast**: Black outlines on white text for readability
- **Font Size**: Large enough to read from typical viewing distance (24-56pt)
- **Button Size**: Minimum 60px tall for easy clicking
- **Keyboard Navigation**: Buttons support focus mode for keyboard/gamepad
- **Color Blind Friendly**: Don't rely solely on color to convey information

---

## Creating the UI in Godot

### Step-by-Step Process

1. **Open Main.tscn**
2. **Add CanvasLayer nodes** for HUD and UI
3. **Build each UI component** following the hierarchies above
4. **Set anchors and positions** as specified
5. **Apply theme overrides** for fonts and colors
6. **Connect button signals** to GameManager functions
7. **Test visibility states**:
   - StartMenu visible on load
   - HUD visible during gameplay
   - GameOver hidden until player dies

### Quick Tips

- **Copy Theme Settings**: Select a node → Inspector → Theme Overrides → Right-click → Copy, then paste to other nodes
- **Preview UI**: Enable "Editable Children" on CanvasLayers to preview overlay in editor
- **Test Layouts**: Change editor zoom to see how UI looks at different scales
- **Use Anchors**: Anchors Preset button in toolbar makes positioning easier

---

This completes the UI design guide. Follow these specifications to create a clean, readable interface for the game.

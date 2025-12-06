extends Node
## Game Manager
## Handles game state, score, difficulty, and asteroid spawning

# Game states
enum GameState { MENU, PLAYING, GAME_OVER }

# Current state
var current_state: GameState = GameState.MENU

# Score tracking
var score: int = 0
var high_score: int = 0

# Difficulty scaling
@export var base_asteroid_count: int = 3
@export var difficulty_increase_score: int = 500  # Score needed to add more asteroids
var current_difficulty_level: int = 0

# Scene references
@export var asteroid_scene: PackedScene
@export var player_scene: PackedScene

# Node references
@onready var spawn_timer = $SpawnTimer
@onready var hud = $"../HUD"  # Assuming HUD is a sibling node
@onready var start_menu = $"../UI/StartMenu"
@onready var game_over_ui = $"../UI/GameOver"

func _ready():
	# Add to game manager group
	add_to_group("game_manager")
	
	# Set up spawn timer
	spawn_timer.wait_time = 5.0  # Spawn new asteroid every 5 seconds
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	
	# Load high score (in a real game, load from file)
	high_score = 0
	
	# Show start menu
	show_start_menu()

func _input(event):
	# Handle escape to return to menu
	if event.is_action_pressed("ui_cancel") and current_state == GameState.PLAYING:
		return_to_menu()

func show_start_menu():
	"""Display the start menu"""
	current_state = GameState.MENU
	if start_menu:
		start_menu.visible = true
	if game_over_ui:
		game_over_ui.visible = false

func start_game():
	"""Initialize and start a new game"""
	current_state = GameState.PLAYING
	score = 0
	current_difficulty_level = 0
	
	# Hide menus
	if start_menu:
		start_menu.visible = false
	if game_over_ui:
		game_over_ui.visible = false
	
	# Clear existing game objects
	clear_game_objects()
	
	# Spawn player
	spawn_player()
	
	# Spawn initial asteroids
	spawn_initial_asteroids()
	
	# Start spawn timer
	spawn_timer.start()
	
	# Update UI
	update_score_display()

func spawn_player():
	"""Create player ship at center of screen"""
	if not player_scene:
		push_error("Player scene not assigned!")
		return
	
	var player = player_scene.instantiate()
	var screen_size = get_viewport().get_visible_rect().size
	player.global_position = screen_size / 2
	get_parent().add_child(player)

func spawn_initial_asteroids():
	"""Spawn starting asteroids"""
	var asteroid_count = base_asteroid_count + current_difficulty_level
	for i in asteroid_count:
		spawn_asteroid()

func spawn_asteroid():
	"""Spawn a single asteroid at a random edge position"""
	if not asteroid_scene:
		push_error("Asteroid scene not assigned!")
		return
	
	var screen_size = get_viewport().get_visible_rect().size
	var asteroid = asteroid_scene.instantiate()
	
	# Random spawn position on screen edge
	var spawn_side = randi() % 4  # 0=top, 1=right, 2=bottom, 3=left
	var spawn_pos = Vector2.ZERO
	var spawn_direction = Vector2.ZERO
	
	match spawn_side:
		0:  # Top
			spawn_pos = Vector2(randf_range(0, screen_size.x), -50)
			spawn_direction = Vector2(randf_range(-0.5, 0.5), 1).normalized()
		1:  # Right
			spawn_pos = Vector2(screen_size.x + 50, randf_range(0, screen_size.y))
			spawn_direction = Vector2(-1, randf_range(-0.5, 0.5)).normalized()
		2:  # Bottom
			spawn_pos = Vector2(randf_range(0, screen_size.x), screen_size.y + 50)
			spawn_direction = Vector2(randf_range(-0.5, 0.5), -1).normalized()
		3:  # Left
			spawn_pos = Vector2(-50, randf_range(0, screen_size.y))
			spawn_direction = Vector2(1, randf_range(-0.5, 0.5)).normalized()
	
	asteroid.global_position = spawn_pos
	asteroid.set_velocity_direction(spawn_direction)
	get_parent().add_child(asteroid)

func _on_spawn_timer_timeout():
	"""Periodically spawn new asteroids during gameplay"""
	if current_state == GameState.PLAYING:
		spawn_asteroid()

func add_score(points: int):
	"""Increase score and check for difficulty increase"""
	score += points
	update_score_display()
	
	# Check for difficulty increase
	var new_difficulty_level = score / difficulty_increase_score
	if new_difficulty_level > current_difficulty_level:
		current_difficulty_level = new_difficulty_level
		# Spawn extra asteroid for increased difficulty
		spawn_asteroid()

func update_score_display():
	"""Update HUD score label"""
	if hud and hud.has_node("ScoreLabel"):
		hud.get_node("ScoreLabel").text = "Score: %d" % score

func player_died():
	"""Handle player death"""
	current_state = GameState.GAME_OVER
	spawn_timer.stop()
	
	# Update high score
	if score > high_score:
		high_score = score
	
	# Show game over screen after brief delay
	await get_tree().create_timer(1.5).timeout
	show_game_over()

func show_game_over():
	"""Display game over screen"""
	if game_over_ui:
		game_over_ui.visible = true
		if game_over_ui.has_node("ScoreLabel"):
			game_over_ui.get_node("ScoreLabel").text = "Score: %d" % score
		if game_over_ui.has_node("HighScoreLabel"):
			game_over_ui.get_node("HighScoreLabel").text = "High Score: %d" % high_score

func return_to_menu():
	"""Return to start menu"""
	spawn_timer.stop()
	clear_game_objects()
	show_start_menu()

func clear_game_objects():
	"""Remove all game objects (player, asteroids, bullets)"""
	get_tree().call_group("player", "queue_free")
	get_tree().call_group("asteroid", "queue_free")
	get_tree().call_group("bullet", "queue_free")

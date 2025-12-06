extends RigidBody2D
## Asteroid enemy
## Floats through space, splits into smaller pieces when destroyed

# Size types
enum AsteroidSize { LARGE, MEDIUM, SMALL }

@export var size: AsteroidSize = AsteroidSize.LARGE
@export var base_speed: float = 100.0
@export var rotation_speed: float = 50.0  # Degrees per second

# Score values
const SCORE_VALUES = {
	AsteroidSize.LARGE: 20,
	AsteroidSize.MEDIUM: 50,
	AsteroidSize.SMALL: 100
}

# Scale values
const SCALE_VALUES = {
	AsteroidSize.LARGE: 1.0,
	AsteroidSize.MEDIUM: 0.6,
	AsteroidSize.SMALL: 0.3
}

var velocity_direction: Vector2
var rotation_direction: float

func _ready():
	# Add to asteroid group
	add_to_group("asteroid")
	
	# Set random rotation direction
	rotation_direction = randf_range(-1.0, 1.0)
	
	# Apply scale based on size
	scale = Vector2.ONE * SCALE_VALUES[size]
	
	# Set random velocity if not already set
	if velocity_direction == Vector2.ZERO:
		velocity_direction = Vector2.RIGHT.rotated(randf() * TAU)
	
	# Apply initial velocity
	linear_velocity = velocity_direction * base_speed
	angular_velocity = rotation_direction * rotation_speed

func _physics_process(delta: float):
	# Rotate the asteroid
	rotation += deg_to_rad(rotation_direction * rotation_speed * delta)
	
	# Screen wrapping
	wrap_around_screen()

func wrap_around_screen():
	"""Wrap asteroid position when going off screen"""
	var screen_size = get_viewport_rect().size
	var margin = 50.0  # Extra space for smooth wrapping
	
	if global_position.x < -margin:
		global_position.x = screen_size.x + margin
	elif global_position.x > screen_size.x + margin:
		global_position.x = -margin
	
	if global_position.y < -margin:
		global_position.y = screen_size.y + margin
	elif global_position.y > screen_size.y + margin:
		global_position.y = -margin

func hit():
	"""Called when asteroid is hit by bullet"""
	# Add score
	get_tree().call_group("game_manager", "add_score", SCORE_VALUES[size])
	
	# Spawn explosion
	spawn_explosion()
	
	# Split into smaller asteroids
	if size != AsteroidSize.SMALL:
		spawn_smaller_asteroids()
	
	# Destroy this asteroid
	queue_free()

func spawn_explosion():
	"""Create visual explosion effect"""
	var explosion_scene = preload("res://scenes/Explosion.tscn")
	var explosion = explosion_scene.instantiate()
	explosion.global_position = global_position
	explosion.scale = scale * 0.8  # Scale explosion with asteroid size
	get_parent().add_child(explosion)

func spawn_smaller_asteroids():
	"""Split into 2-3 smaller asteroids"""
	var next_size = AsteroidSize.MEDIUM if size == AsteroidSize.LARGE else AsteroidSize.SMALL
	var num_pieces = randi_range(2, 3)
	
	for i in num_pieces:
		var new_asteroid = duplicate()
		new_asteroid.size = next_size
		new_asteroid.global_position = global_position
		
		# Set random velocity for the new piece
		var angle = (TAU / num_pieces) * i + randf_range(-0.5, 0.5)
		new_asteroid.velocity_direction = Vector2.RIGHT.rotated(angle)
		
		get_parent().call_deferred("add_child", new_asteroid)

func set_velocity_direction(direction: Vector2):
	"""Set the movement direction (used when spawning)"""
	velocity_direction = direction.normalized()
	linear_velocity = velocity_direction * base_speed

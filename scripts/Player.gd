extends CharacterBody2D
## Player ship controller
## Handles movement, rotation, shooting, and collision detection

# Ship properties
@export var rotation_speed: float = 200.0  # Degrees per second
@export var thrust_power: float = 500.0    # Forward acceleration
@export var max_speed: float = 400.0       # Maximum velocity
@export var friction: float = 0.98         # Velocity decay when not thrusting

# Shooting properties
@export var bullet_scene: PackedScene
@export var shoot_cooldown: float = 0.25   # Seconds between shots
var can_shoot: bool = true

# References
@onready var sprite = $Sprite2D
@onready var shoot_timer = $ShootTimer
@onready var muzzle = $Muzzle  # Position where bullets spawn

func _ready():
	# Set up shoot timer
	shoot_timer.wait_time = shoot_cooldown
	shoot_timer.one_shot = true
	shoot_timer.timeout.connect(_on_shoot_timer_timeout)
	
	# Add to player group for easy reference
	add_to_group("player")

func _physics_process(delta: float):
	# Handle rotation
	var rotation_input = Input.get_axis("move_left", "move_right")
	rotation_degrees += rotation_input * rotation_speed * delta
	
	# Handle thrust
	if Input.is_action_pressed("move_up"):
		var thrust_direction = Vector2.UP.rotated(rotation)
		velocity += thrust_direction * thrust_power * delta
		
		# Clamp to max speed
		if velocity.length() > max_speed:
			velocity = velocity.normalized() * max_speed
	
	# Apply friction
	velocity *= friction
	
	# Handle shooting
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()
	
	# Move the ship
	move_and_slide()
	
	# Screen wrapping
	wrap_around_screen()

func shoot():
	"""Spawn a bullet at the muzzle position"""
	if not bullet_scene:
		push_warning("Bullet scene not assigned to Player!")
		return
	
	can_shoot = false
	shoot_timer.start()
	
	# Create bullet instance
	var bullet = bullet_scene.instantiate()
	bullet.global_position = muzzle.global_position
	bullet.rotation = rotation
	
	# Add bullet to the scene (parent it to the game root)
	get_parent().add_child(bullet)
	
	# Optional: Play shoot sound here
	# $ShootSound.play()

func _on_shoot_timer_timeout():
	"""Re-enable shooting after cooldown"""
	can_shoot = true

func wrap_around_screen():
	"""Wrap player position when going off screen"""
	var screen_size = get_viewport_rect().size
	
	if global_position.x < 0:
		global_position.x = screen_size.x
	elif global_position.x > screen_size.x:
		global_position.x = 0
	
	if global_position.y < 0:
		global_position.y = screen_size.y
	elif global_position.y > screen_size.y:
		global_position.y = 0

func _on_body_entered(body: Node2D):
	"""Handle collision with asteroids"""
	if body.is_in_group("asteroid"):
		die()

func die():
	"""Handle player death"""
	# Spawn explosion effect
	var explosion_scene = preload("res://scenes/Explosion.tscn")
	var explosion = explosion_scene.instantiate()
	explosion.global_position = global_position
	get_parent().add_child(explosion)
	
	# Notify game manager
	get_tree().call_group("game_manager", "player_died")
	
	# Remove player
	queue_free()

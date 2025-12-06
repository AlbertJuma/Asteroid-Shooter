extends Area2D
## Bullet projectile
## Flies in a straight line and destroys asteroids on contact

@export var speed: float = 600.0
@export var lifetime: float = 2.0  # Seconds before auto-destroy

func _ready():
	# Set up groups
	add_to_group("bullet")
	
	# Set up collision detection
	body_entered.connect(_on_body_entered)
	
	# Auto-destroy after lifetime
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta: float):
	# Move forward based on rotation
	position += Vector2.UP.rotated(rotation) * speed * delta
	
	# Optional: Destroy if off-screen (more efficient than waiting for lifetime)
	var screen_size = get_viewport_rect().size
	if position.x < -50 or position.x > screen_size.x + 50 or \
	   position.y < -50 or position.y > screen_size.y + 50:
		queue_free()

func _on_body_entered(body: Node2D):
	"""Handle collision with asteroids"""
	if body.is_in_group("asteroid"):
		# Destroy the asteroid
		body.hit()
		
		# Destroy this bullet
		queue_free()

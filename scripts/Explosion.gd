extends Node2D
## Explosion visual effect
## Displays particles/animation and destroys itself when complete

@export var duration: float = 0.5  # Seconds before auto-destroy
@export var particle_count: int = 12
@export var particle_speed: float = 150.0
@export var particle_size: float = 4.0

var particles: Array[Line2D] = []
var time_elapsed: float = 0.0

func _ready():
	# Create particle lines radiating outward
	for i in particle_count:
		var line = Line2D.new()
		line.width = particle_size
		line.default_color = Color(1.0, 0.8, 0.2)  # Yellow-orange
		
		# Random angle for each particle
		var angle = (TAU / particle_count) * i + randf_range(-0.2, 0.2)
		var direction = Vector2.RIGHT.rotated(angle)
		
		# Store direction as metadata for movement
		line.set_meta("direction", direction)
		line.set_meta("length", 0.0)
		
		add_child(line)
		particles.append(line)
	
	# Auto-destroy after duration
	await get_tree().create_timer(duration).timeout
	queue_free()

func _process(delta: float):
	time_elapsed += delta
	var progress = time_elapsed / duration
	
	for line in particles:
		var direction = line.get_meta("direction") as Vector2
		var length = line.get_meta("length") as float
		
		# Expand particle
		length += particle_speed * delta
		line.set_meta("length", length)
		
		# Update line points
		line.clear_points()
		line.add_point(Vector2.ZERO)
		line.add_point(direction * length)
		
		# Fade out over time
		var alpha = 1.0 - progress
		line.modulate.a = alpha

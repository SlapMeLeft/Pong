extends CharacterBody2D

@export var speed: float = 200.0


func _ready() -> void:
	randomize()
	initialize()


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)

	# Bounce off any physics bodies (paddles/walls, if the menu has them)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		
		
func initialize() -> void:
	var extra_offset = 0.0 if randf() < 0.5 else PI
	var angle = extra_offset + randf_range(-PI / 3, PI / 3)
	velocity = Vector2(cos(angle), sin(angle)).normalized() * speed
	global_position = get_viewport_rect().size / 2.0

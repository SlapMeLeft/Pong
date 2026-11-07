extends CharacterBody2D


@export var speed = 350
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_just_pressed("ui_down"):
		velocity = Vector2(0, speed)
	if Input.is_action_just_pressed("ui_up"):
		velocity = Vector2(0, -speed)
	if Input.is_action_just_released("ui_up") or Input.is_action_just_released("ui_down"):
		velocity = Vector2.ZERO
	
	move_and_slide()

	if Input.is_action_pressed("quit"):
		get_tree().quit()

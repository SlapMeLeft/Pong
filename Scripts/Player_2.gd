extends CharacterBody2D

@export var speed = 375.0


func _physics_process(delta: float) -> void:
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	
	#Moving the pong paddles up and down
	if up and not down:
		velocity = Vector2(0, -speed)
	elif down and not up:
		velocity = Vector2(0, speed)
	elif not up and not down:
		velocity = Vector2(0, 0)
	if Input.is_action_just_released("ui_up") or Input.is_action_just_released("ui_down"):
		velocity = Vector2.ZERO
	
	move_and_slide()

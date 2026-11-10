extends CharacterBody2D

@onready var p_1_score_anim: AnimationPlayer = $"../Player 1 Score/P1 score anim"
@onready var p_2_score_anim: AnimationPlayer = $"../Player 2 Score/P2 score anim"
@onready var wobble_p_1: AnimationPlayer = $"../Player 1 Score/wobble p1"
@onready var wobble_p_2: AnimationPlayer = $"../Player 2 Score/wobble p2"

@onready var player_1_score: Label = $"../Player 1 Score"
@onready var player_2_score: Label = $"../Player 2 Score"
@onready var ball_speed: Label = $"../Ball Speed"

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var ball: CharacterBody2D = $"."

@onready var pause_menu: CanvasLayer = $"../Pause Menu"

@export var snap_back_speed: float = 8.0
@export var bounce_variation: float = 50

var speed = 150
const MAX_SPEED = 750.0
var p1_score = 0
var p2_score = 0


func _ready() -> void:
	wobble_p_1.play("Wobble")
	wobble_p_2.play("wobble")
	p1_score = 0
	p2_score = 0
	initialize()
	print("Menu loaded")
	print("Paused: ", get_tree().paused)


func _process(delta: float) -> void:
	if PauseManager.visible:
		set_physics_process(false)
		wobble_p_1.pause()
		wobble_p_2.pause()
	else:
		set_physics_process(true)
		wobble_p_1.play("Wobble")
		wobble_p_2.play("wobble")


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		velocity = velocity.bounce(collision.get_normal())
		
		if collider is CollisionObject2D:
			audio_stream_player_2d.pitch_scale = randf_range(0.8, 1.4)
			print(str(audio_stream_player_2d.pitch_scale))
			audio_stream_player_2d.play()
			
		if collider is CharacterBody2D:
			speed = min(speed + 50, MAX_SPEED)
			if speed >= MAX_SPEED:
				ball_speed.set("theme_override_colors/font_color", Color(1.0, 0.0, 0.0, 1.0))
			elif speed >= 350:
				ball_speed.set("theme_override_colors/font_color", Color(1.0, 0.5, 0.0, 1.0))
			else:
				ball_speed.set("theme_override_colors/font_color", Color(0.214, 0.781, 0.346, 1.0))
				
			velocity = velocity.normalized() * speed
		
		velocity.x += randf_range(-bounce_variation, bounce_variation)
		velocity.y += randf_range(-bounce_variation, bounce_variation)
		
		var min_y = speed * 0.25

		if abs(velocity.y) < min_y:
			velocity.y = min_y * sign(velocity.y) if velocity.y != 0 else min_y * (1 if randf() > 0.5 else -1)
		
		velocity = velocity.normalized() * speed
		
	ball_speed.text = "Ball Speed - " + str(int(speed))


func initialize():
		speed = 150
		ball_speed.set("theme_override_colors/font_color", (Color(0.214, 0.781, 0.346, 1.0)))
		var extra_offset = 0.0 if randf() < 0.5 else PI
		var angle = extra_offset + randf_range(-PI/3, PI/3)
		velocity = Vector2(cos(angle), sin(angle)).normalized()*speed
		global_position = get_viewport_rect().size / 2.0


func _on_left_wall_body_entered(body: Node2D) -> void:
	if body != self:
		return
	var current_speed = velocity.length()
	if current_speed < 700:
		p2_score += 1
		player_2_score.text = str(p2_score)
	if current_speed > 700:
		p2_score += 2
		player_2_score.text = str(p2_score)
	p_2_score_anim.play("player_score")
	end_game()
	initialize()
	

func _on_right_wall_body_entered(body: Node2D) -> void:
	if body != self:
		return
	var current_speed = velocity.length()
	if current_speed < 700:
		p1_score += 1
		player_1_score.text = str(p1_score)
	if current_speed > 700:
		p1_score += 2
		player_1_score.text = str(p1_score)
	p_1_score_anim.play("player_score")
	end_game()
	initialize()
	
	
func end_game():
	if p1_score > SaveManager.p1_high_score:
		SaveManager.p1_save_score(p1_score)
	if p2_score > SaveManager.p2_high_score:
		SaveManager.p2_save_score(p2_score)
	
	

extends Control

@onready var animation_player: AnimationPlayer = $"Ball Speed/AnimationPlayer"
@onready var player_2: CharacterBody2D = $"Player 2"
@onready var player_1: CharacterBody2D = $"Player 1"


func _ready() -> void:
	PauseManager.hide()
	animation_player.play("Idle_rotate")


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("quit"):
		if get_tree().paused:
			get_tree().paused = false
			PauseManager.hide()
			SettingsManager.hide()
			animation_player.play("Idle_rotate")
		else:
			get_tree().paused = true
			PauseManager.show()
			animation_player.pause()
	
	

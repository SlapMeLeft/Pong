extends Control

@onready var pause_menu: CanvasLayer = $"Pause Menu"
@onready var animation_player: AnimationPlayer = $"Ball Speed/AnimationPlayer"


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("quit"):
		if get_tree().paused:
			get_tree().paused = false
			pause_menu.hide()
		else:
			pause_menu.show()
			animation_player.pause()
			
		
func _ready() -> void:
	animation_player.play("Idle_rotate")
	

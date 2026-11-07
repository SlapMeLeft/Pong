extends CanvasLayer


@onready var pause_menu: CanvasLayer = $"."
@onready var animation_player: AnimationPlayer = $"../Ball Speed/AnimationPlayer"


func _on_resume_pressed() -> void:
	pause_menu.hide()
	set_physics_process(true)
	animation_player.play()


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	pause_menu.hide()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main_Menu.tscn")
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	pause_menu.hide()
	
	
func _on_quit_pressed() -> void:
	get_tree().quit()
	
	

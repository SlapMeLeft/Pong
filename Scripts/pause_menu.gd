extends CanvasLayer

@onready var pause_menu: CanvasLayer = $"."


func _on_resume_pressed() -> void:
	unpaused()
	pause_menu.hide()
	get_tree().paused = false
	SettingsManager.get_node("%Button").hide()

func _on_restart_pressed() -> void:
	unpaused()
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	pause_menu.hide()
	
	
func _on_settings_pressed() -> void:
	pause_menu.hide()
	SettingsManager.show()
	SettingsManager.get_node("%Button").show()
	

func _on_main_menu_pressed() -> void:
	unpaused()
	get_tree().change_scene_to_file("res://Scenes/Main_Menu.tscn")
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	pause_menu.hide()
	
	
func _on_quit_pressed() -> void:
	get_tree().quit()
	

func unpaused() -> void:
	print("GAME WAS UNPAUSED BY:")
	print_stack()
	get_tree().paused = false
	

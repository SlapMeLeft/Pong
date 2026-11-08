extends Control

@onready var animation_player: AnimationPlayer = $Title/AnimationPlayer


@onready var high_score_label: Label = $HighScore
@onready var p1_high_score: Label = $p1HighScore
@onready var p2_high_score: Label = $HighScore2





func _ready() -> void:
	animation_player.play("Title_anim")
	
	p1_high_score.text = "Player 1 HighScore - " + str(SaveManager.p1_high_score)
	p2_high_score.text = "Player 2 HighScore - " + str(SaveManager.p2_high_score)
	
	
func _on_play_button_pressed() -> void:
	print("BUTTON PRESSED")
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	

func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/settings.tscn")
	Settings.show()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
	
	

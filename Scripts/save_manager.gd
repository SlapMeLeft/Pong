extends Node

const SAVE_PATH = "user://highscore.cfg"



var p2_high_score: int = 0
var p1_high_score: int = 0




func _ready() -> void:
	load_high_score()
	
func p1_save_score(new_score: int):
	p1_high_score = new_score
	_save_all()
	
func p2_save_score(new_score: int):
	p2_high_score = new_score
	_save_all()
	
func _save_all():
	var config = ConfigFile.new()
	config.set_value("SaveData", "p1_high_score", p1_high_score)
	config.set_value("SaveData", "p2_high_score", p2_high_score)
	config.save(SAVE_PATH)
	
func load_high_score():
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) == OK:
		p1_high_score = config.get_value("SaveData", "p1_high_score", 0)
		p2_high_score = config.get_value("SaveData", "p2_high_score", 0)

func reset_save():
	p1_high_score = 0
	p2_high_score = 0
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)
		
	_save_all()

extends Node

@onready var fps_label: Label = $"FPS/FPS Label"


func _ready() -> void:
	Engine.max_fps = 0
	_set_bus("SFX", 0.1)
	_set_bus("Music", 0.1)
	_set_bus("Master", 0.1)


func _set_bus(bus_name: String, linear_value: float) -> void:
	var idx := AudioServer.get_bus_index(bus_name)
	if idx == -1:
		push_warning("Audio bus not found: " + bus_name)
		return
	AudioServer.set_bus_volume_db(idx, linear_to_db(linear_value))


func _process(delta: float) -> void:
	
	##If visible is true, it becomes false.
	##If visible is false, it becomes true.
	if Input.is_action_just_pressed("FPS"):
		fps_label.visible = !fps_label.visible
		
	fps_label.text = "FPS : " + str(Engine.get_frames_per_second())

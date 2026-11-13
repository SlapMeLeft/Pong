extends CanvasLayer

signal fps

@onready var settings: CanvasLayer = $"."

@onready var confirm: Button = $"Save Reset/Confirm"
@onready var reset_save: Button = $"Save Reset/Reset Save"
@onready var music_volume: HSlider = $"Settings/Music Volume"
@onready var sfx_volume: HSlider = $"Settings/Sfx Volume"

@onready var sfx_audio_test: AudioStreamPlayer2D = $"SFX Audio test"

var sfx_bus_index: int
var music_bus_index: int


func _ready() -> void:
	sfx_bus_index = AudioServer.get_bus_index("SFX")
	sfx_volume.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus_index))
	sfx_volume.value_changed.connect(_on_sfx_volume_changed)

	music_bus_index = AudioServer.get_bus_index("Music")
	music_volume.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus_index))
	music_volume.value_changed.connect(_on_music_volume_changed)

	hide()
	
	print("Settings node: ", get_path())
	print("Pause Menu: ", get_node_or_null("../Pause Menu"))


func _process(float) -> void:
	pass
	pass


func _on_sfx_volume_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus_index, linear_to_db(value))


func _on_music_volume_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus_index, linear_to_db(value))


func _on_reset_save_pressed() -> void:
	confirm.show()
	reset_save.hide()
	

func _on_confirm_pressed() -> void:
	confirm.hide()
	reset_save.show()
	SaveManager.reset_save()
	

func _on_sfx_test_pressed() -> void:
	sfx_audio_test.play()


func _on_fullscreen_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	get_window().borderless = true


func _on_windowed_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	get_window().borderless = false


func _on_boderless_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	get_window().borderless = true


func _on_fullscreen_borderless_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	get_window().borderless = true
	
	
func _on_button_pressed() -> void:
	hide()
	SettingsManager.get_node("%Button").hide()
	PauseManager.show()
	get_tree().paused = true

func _on_button_2_pressed() -> void:
	hide()
	PauseManager.hide()
	SettingsManager.get_node("%Button2").hide()
	

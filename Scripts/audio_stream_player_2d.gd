extends AudioStreamPlayer2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"."

func _ready() -> void:
	if stream:
		play()
	else:
		print("beans")

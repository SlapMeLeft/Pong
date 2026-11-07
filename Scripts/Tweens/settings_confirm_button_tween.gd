extends Button

var tween: Tween
@export var button_tween_scale: float = 1.15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered() -> void:
	reset_tween()
	pivot_offset = size / 2
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale",Vector2(button_tween_scale, button_tween_scale), 0.4)
	
func _on_mouse_exited() -> void:
	reset_tween()
	pivot_offset = size / 2
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale",Vector2.ONE, 0.4)

func reset_tween() -> void:
	if tween:
		tween.kill()
	tween = create_tween()

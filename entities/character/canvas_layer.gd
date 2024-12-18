extends CanvasLayer

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_toogle"):
		visible = not visible

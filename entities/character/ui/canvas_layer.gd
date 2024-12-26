extends CanvasLayer

@export var interaction_label: Label
@export var progress_container: MarginContainer
@export var progress_bar: ProgressBar

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_toogle"):
		visible = not visible

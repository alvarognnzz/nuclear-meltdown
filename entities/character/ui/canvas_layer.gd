extends CanvasLayer

@export var interaction_label: Label
@export var progress_container: MarginContainer
@export var progress_bar: ProgressBar

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_toggle"):
		visible = not visible

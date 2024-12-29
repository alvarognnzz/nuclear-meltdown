extends MarginContainer

@onready var progress_bar: ProgressBar = $CenterContainer/ProgressBar

func _ready() -> void:
	visible = false
	EventBus.change_interaction_progress.connect(change_interaction_progress)

func change_interaction_progress(value) -> void:
	progress_bar.value = value

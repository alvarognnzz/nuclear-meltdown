extends PanelContainer

func _ready() -> void:
	visible = false
	EventBus.object_being_moved.connect(set_visibility)

func set_visibility(value: bool) -> void:
	visible = value

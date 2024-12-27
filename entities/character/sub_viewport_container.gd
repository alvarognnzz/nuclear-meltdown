extends SubViewportContainer

func _ready() -> void:
	scale = Vector2(get_viewport_rect().size.x/size.x, get_viewport_rect().size.x/size.x)
	EventBus.resolution_changed.connect(resolution_changed)

func resolution_changed(width, height) -> void:
	scale = Vector2(width/size.x, width/size.x)

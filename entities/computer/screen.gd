extends Sprite3D

@onready var sub_viewport: SubViewport = $"../SubViewport"

func _ready() -> void:
	texture = sub_viewport.get_texture()

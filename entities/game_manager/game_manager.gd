extends Node

func _ready() -> void:
	Console.add_command("fullscreen", toogle_fullscreen)
	Console.add_command("highres", toogle_resolution)

func toogle_fullscreen() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func toogle_resolution() -> void:
	if get_tree().root.content_scale_mode == Window.CONTENT_SCALE_MODE_DISABLED:
		get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT
	else:
		get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_DISABLED
	

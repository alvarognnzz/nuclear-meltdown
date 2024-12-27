extends Node

func _ready() -> void:
	Console.add_command("fullscreen", toggle_fullscreen)
	Console.add_command("vsync", toggle_vsync)
	Console.add_command("resolution", set_resolution, ["width", "height"], 2, "Sets the resolution to the specified width and height.")

func toggle_fullscreen() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		var screen_size = DisplayServer.screen_get_size(0)
		EventBus.resolution_changed.emit(screen_size.x, screen_size.y)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		var window_size = get_window().get_size()
		EventBus.resolution_changed.emit(window_size.x, window_size.y)

func toggle_vsync() -> void:
	if DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_DISABLED:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func set_resolution(width: String, height: String) -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		var window_size = get_window().get_size()
		EventBus.resolution_changed.emit(window_size.x, window_size.y)
	
	var width_int = int(width)
	var height_int = int(height)
	get_window().set_size(Vector2i(width_int, height_int))
	EventBus.resolution_changed.emit(get_viewport().size.x, get_viewport().size.y)
	center_window()

func center_window() -> void:
	var screen_size = DisplayServer.screen_get_size(0)
	var window_size = get_window().get_size()
	var position = (screen_size - window_size) / 2
	DisplayServer.window_set_position(position)

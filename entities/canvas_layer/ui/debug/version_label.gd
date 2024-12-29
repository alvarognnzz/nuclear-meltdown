extends Label

const VERSION_PATH = "res://version.txt"

func _ready() -> void:
	if FileAccess.file_exists(VERSION_PATH):
		var file = FileAccess.open(VERSION_PATH, FileAccess.READ)
		text = file.get_as_text().strip_edges()
		file.close()
	else:
		text = "Version file not found"

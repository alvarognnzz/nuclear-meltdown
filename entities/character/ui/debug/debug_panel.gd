extends PanelContainer

@onready var v_box_container: VBoxContainer = $MarginContainer/VBoxContainer

const LABEL_SETTINGS = preload("res://entities/character/ui/debug/debug_label.tres")

var character: CharacterBody3D
var labels = {}

func _ready() -> void:
	character = get_tree().get_first_node_in_group("character")
	add_variable_label("FPS", self.get_fps)

func _physics_process(_delta: float) -> void:
	update_labels()

func add_variable_label(label_name: String, getter: Callable) -> void:
	var label = Label.new()
	label.name = label_name
	label.label_settings = LABEL_SETTINGS
	v_box_container.add_child(label)
	labels[label_name] = {"label": label, "getter": getter}

func update_labels() -> void:
	for label_data in labels.values():
		label_data["label"].text = label_data["getter"].call()

func get_fps() -> String:
	return "FPS: " + str(Engine.get_frames_per_second())

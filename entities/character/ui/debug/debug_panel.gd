extends PanelContainer

@onready var v_box_container: VBoxContainer = $MarginContainer/VBoxContainer

const LABEL_SETTINGS = preload("res://entities/character/ui/debug/debug_label.tres")

var variables: Dictionary

var character: CharacterBody3D

func _ready() -> void:
	character = get_tree().get_first_node_in_group("character")

func _physics_process(delta: float) -> void:
	variables = {
		"variable1": {"name": "FPS", "value": Engine.get_frames_per_second()},
		"variable2": {"name": "Speed", "value": character.speed},
	}

	update_labels()

func update_labels() -> void:
	var current_labels = {}
	for label in v_box_container.get_children():
		current_labels[label.name] = label
	
	for key in variables.keys():
		var entry = variables[key]
		if current_labels.has(entry.name):
			current_labels[entry.name].text = entry.name + ": " + str(entry.value)
		else:
			create_label(entry.name, entry.value)

func create_label(name: String, value: Variant) -> void:
	var label = Label.new()
	label.name = name
	label.text = name + ": " + str(value)
	label.label_settings = LABEL_SETTINGS
	v_box_container.add_child(label)

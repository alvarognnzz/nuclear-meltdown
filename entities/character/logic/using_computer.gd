extends Node

var character: CharacterBody3D

var using_computer: bool = false
var character_transform: Transform3D
var previous_transform: Transform3D
var freeze_player: bool = false

func _ready() -> void:
	character = get_tree().get_first_node_in_group("character")
	EventBus.using_computer.connect(set_using_computer)

func _physics_process(delta: float) -> void:
	if using_computer:
		character.head.rotation = Vector3.ZERO
		character.movement_enabled = false
		character.set_collision_layer_value(2, false)
		character.set_collision_mask_value(2, false)
		if freeze_player:
			character.global_transform = character_transform

func set_using_computer(value, global_transform) -> void:
	if value:
		using_computer = true
		previous_transform = character.global_transform
		character_transform = global_transform
		var tween = create_tween()
		tween.tween_property(
			character,
			"global_transform",
			character_transform,
			1.0,
		)
		tween.finished.connect(_on_tween_finished)
	else:
		using_computer = false
		freeze_player = false
		var tween = create_tween()
		tween.tween_property(
			character,
			"global_transform",
			previous_transform,
			1.0,
		)
		tween.finished.connect(_on_restore_finished)

func _on_tween_finished() -> void:
	freeze_player = true

func _on_restore_finished() -> void:
	character.movement_enabled = true
	character.set_collision_layer_value(2, true)
	character.set_collision_mask_value(2, true)

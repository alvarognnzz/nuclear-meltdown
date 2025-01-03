class_name Pickable
extends Node

@export var in_character_position: Vector3
@export var in_character_rotation: Vector3

@export var audio_stream_player: AudioStreamPlayer 

var progress_speed = 1
var picked: bool = false

var previous_parent
var character: CharacterBody3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
const fall_multiplier: float = 2.5

var parent: RigidBody3D
var meshes: Array

func _ready() -> void:
	if not get_parent() is RigidBody3D:
		push_error("Pickable.gd: Parent must be a RigidBody3D")
	
	parent = get_parent()
	meshes = get_all_meshes(parent)
	character = get_tree().get_first_node_in_group("character")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("drop") and picked:
		if audio_stream_player:
			audio_stream_player.pitch_scale = randf_range(0.7, 0.8)
			audio_stream_player.play()
		
		picked = false
		character.picking = false
		parent.reparent(previous_parent)
		parent.freeze = false
		parent.global_position = character.global_position
		parent.global_rotation = Vector3.ZERO
		
		for mesh in meshes:
			mesh.set_layer_mask_value(2, false)

func start_picking() -> void:
	if audio_stream_player:
		audio_stream_player.pitch_scale = randf_range(0.9, 1.1)
		audio_stream_player.play()
	
	for mesh in meshes:
		mesh.set_layer_mask_value(2, true)
	
	previous_parent = parent.get_parent()
	picked = true
	character.picking = true
	var picking_pivot = character.picking_pivot
	parent.reparent(picking_pivot)
	parent.freeze = true
	parent.position = in_character_position
	parent.rotation = in_character_rotation

func get_all_meshes(node: Node) -> Array:
	var meshes = []
	if node is MeshInstance3D:
		meshes.append(node)
	for child in node.get_children():
		meshes += get_all_meshes(child)
	return meshes

#func can_interact() -> bool:
	#return not character.picking

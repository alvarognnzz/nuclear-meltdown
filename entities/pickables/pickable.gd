extends RigidBody3D

@export var key: String
@export var input_action: String
@export var action_name: String

@export var interaction_type: Global.InteractionTypes = Global.InteractionTypes.INSTANT
@export var in_character_position: Vector3 = Vector3.ZERO
@export var in_character_rotation: Vector3 = Vector3.ZERO

var progress_speed = 1
var picked: bool = false

var previous_parent
var character: CharacterBody3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
const fall_multiplier: float = 2.5

func _ready() -> void:
	character = get_tree().get_first_node_in_group("character")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("drop") and picked:
		picked = false
		character.picking = false
		reparent(previous_parent)
		freeze = false
		global_position = character.global_position
		global_rotation = Vector3.ZERO

func interact() -> void:
	previous_parent = get_parent()
	picked = true
	character.picking = true
	var picking_pivot = character.picking_pivot
	reparent(picking_pivot)
	freeze = true
	position = in_character_position
	rotation = in_character_rotation

func can_interact() -> bool:
	return not character.picking

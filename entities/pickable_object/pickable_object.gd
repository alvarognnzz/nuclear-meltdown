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

var interaction: Dictionary = {
	"key": "E",
	"input": "interact",
	"name": "Pick object",
}

func _ready() -> void:
	character = get_tree().get_first_node_in_group("character")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("drop") and picked:
		picked = false
		freeze = false
		collision_layer = 1
		collision_mask = 1
		var direction = (global_transform.origin - character.global_transform.origin).normalized()
		var impulse = direction * 2
		apply_central_impulse(impulse)
		var adjusted_position = ensure_above_ground(global_transform.origin)
		global_transform.origin = adjusted_position
		reparent(previous_parent)

func interact() -> void:
	previous_parent = get_parent()
	picked = true
	var picking_pivot = character.picking_pivot
	reparent(picking_pivot)
	position = in_character_position
	rotation = in_character_rotation
	freeze = true
	collision_layer = 0
	collision_mask = 0

func can_interact() -> bool:
	return not picked

func ensure_above_ground(new_position: Vector3) -> Vector3:
	var ground_y = character.global_position.y - 0.5
	var safety_margin = 0.1
	if new_position.y < ground_y + safety_margin:
		new_position.y = ground_y + safety_margin
	return new_position

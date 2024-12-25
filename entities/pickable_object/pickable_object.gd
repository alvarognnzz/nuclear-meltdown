extends RigidBody3D

@export var interaction_type: Global.InteractionTypes = Global.InteractionTypes.INSTANT

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
		reparent(previous_parent)

func interact() -> void:
	previous_parent = get_parent()
	picked = true
	var picking_pivot = character.picking_pivot
	reparent(picking_pivot)
	freeze = true
	collision_layer = 0
	collision_mask = 0

func can_interact() -> bool:
	if picked:
		return false
	else:
		return true

extends RigidBody3D

@export var interaction_type: Global.InteractionTypes = Global.InteractionTypes.INSTANT

var progress_speed = 1

var interaction: Dictionary = {
	"key": "E",
	"input": "interact",
	"name": "Pick object",
}

func interact() -> void:
	var picking_pivot = get_tree().get_first_node_in_group("character").picking_pivot
	freeze = true
	reparent(picking_pivot)

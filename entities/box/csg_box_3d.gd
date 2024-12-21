extends CSGBox3D

@export var interaction_type: Global.InteractionTypes = Global.InteractionTypes.PROGRESS

var progress_speed = 1

var interaction: Dictionary = {
	"key": "E",
	"input": "interact",
	"name": "Move to room",
}

func interact() -> void:
	get_tree().get_first_node_in_group("character").global_position = Vector3(-2, 2.5, -12.3)

extends CSGBox3D

@export var interaction_type: Global.InteractionTypes = Global.InteractionTypes.PROGRESS
@export var key: String = "E"
@export var input_action: String = "interact"
@export var action_name: String

@export var progress_speed = 1

func interact() -> void:
	get_tree().get_first_node_in_group("character").global_position = Vector3(-2, 2.5, -12.3)

extends StaticBody3D

@export var interaction_type: Global.InteractionTypes = Global.InteractionTypes.INSTANT
@onready var animation_player: AnimationPlayer = $Visuals/AnimationPlayer
@export var key: String = "E"
@export var input_action: String = "interact"
@export var action_name: String

func interact() -> void:
	EventBus.toggle_elevator_door.emit()
	animation_player.play("push_button")

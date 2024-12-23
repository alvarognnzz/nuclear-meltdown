extends StaticBody3D

@export var interaction_type: Global.InteractionTypes = Global.InteractionTypes.INSTANT
@onready var animation_player: AnimationPlayer = $Visuals/AnimationPlayer

var interaction: Dictionary = {
	"key": "E",
	"input": "interact",
	"name": "Open door",
}

func interact() -> void:
	EventBus.toogle_elevator_door.emit()
	animation_player.play("push_button")

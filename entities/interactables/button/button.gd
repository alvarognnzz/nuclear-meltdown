extends StaticBody3D

@onready var animation_player: AnimationPlayer = $Visuals/AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@export var interaction_type: Global.InteractionTypes = Global.InteractionTypes.INSTANT
@export var key: String = "E"
@export var input_action: String = "interact"
@export var action_name: String

func interact() -> void:
	animation_player.play("push_button")

func toggle_elevator_door() -> void:
	EventBus.toggle_elevator_door.emit()
	audio_stream_player.play()

extends StaticBody3D

@onready var animation_player: AnimationPlayer = $Visuals/AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func toggle_elevator_door() -> void:
	EventBus.toggle_elevator_door.emit()
	audio_stream_player.play()

func _on_interactable_interacted() -> void:
	animation_player.play("push_button")

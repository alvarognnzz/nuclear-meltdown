extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

enum State {OPEN, CLOSED}
var state: State = State.CLOSED

func _ready() -> void:
	EventBus.toggle_elevator_door.connect(toggle_elevator_door)

func toggle_elevator_door():
	if state == State.CLOSED:
		state = State.OPEN
		animation_player.play("open_door")
	else:
		state = State.CLOSED
		animation_player.play_backwards("open_door")

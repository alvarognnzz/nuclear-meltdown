extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

enum State {OPEN, CLOSED}
var state: State = State.CLOSED

func _ready() -> void:
	EventBus.toogle_elevator_door.connect(toogle_elevator_door)

func toogle_elevator_door():
	if state == State.CLOSED:
		state = State.OPEN
		animation_player.play("open_door")
	else:
		state = State.CLOSED
		animation_player.play_backwards("open_door")

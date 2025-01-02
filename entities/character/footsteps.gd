extends AudioStreamPlayer

@onready var step_timer: Timer = $StepTimer

var concrete_streams = [
	preload("res://common/sounds/footsteps/concrete/footsteps_concrete1.ogg"),
	preload("res://common/sounds/footsteps/concrete/footsteps_concrete2.ogg"),
	preload("res://common/sounds/footsteps/concrete/footsteps_concrete3.ogg"),
	preload("res://common/sounds/footsteps/concrete/footsteps_concrete4.ogg")
]

var character: CharacterBody3D

func _ready() -> void:
	character = get_tree().get_first_node_in_group("character")
	step_timer.start()

func _physics_process(delta: float) -> void:
	if character:
		adjust_step_timer()

func adjust_step_timer():
	if character.is_on_floor() and character.velocity.length() > 0.4:
		step_timer.wait_time = calculate_step_interval(character.speed) * randf_range(0.9, 1.1)
		if step_timer.is_stopped():
			step_timer.start()
	else:
		step_timer.stop()

func calculate_step_interval(speed: float) -> float:
	if speed == 5.0:
		return 0.6
	else:
		return 0.4

func _on_step_timer_timeout() -> void:
	stream = concrete_streams[randi() % concrete_streams.size()]
	pitch_scale = randf_range(0.7, 1.2)
	play()

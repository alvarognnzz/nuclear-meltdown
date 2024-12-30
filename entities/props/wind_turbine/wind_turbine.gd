extends StaticBody3D

@onready var windturbine_blades: MeshInstance3D = $"Visuals/Windturbine Blades"
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var rotation_speed: float

func _ready() -> void:
	start_rotation()
	timer.start()

func start_rotation() -> void:
	rotation_speed = randf_range(1.0, 3.0)
	animation_player.speed_scale = rotation_speed

func _on_timer_timeout() -> void:
	start_rotation()
	timer.start()

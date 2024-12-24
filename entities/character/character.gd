extends CharacterBody3D

@export var head: Node3D
@export var camera: Camera3D
@onready var sprinting_progress_bar: ProgressBar = $CanvasLayer/Stamina/MarginContainer/ProgressBar

const walking_speed := 5.0
const sprinting_speed := 6.5

const jump_velocity := 4.5

const mouse_sensibility := 0.1

const lerp_speed := 10.0
const fall_multiplier := 2.5

const bob_frequency := 2.0
const bob_amplitude := 0.04
var bob: float = 0.0

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var speed: float = walking_speed
var can_sprint: bool = true

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensibility))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensibility))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-80), deg_to_rad(60))

func _physics_process(delta: float) -> void:
	handle_sprinting()
	
	handle_gravity(delta)

	handle_jumping()

	handle_movement(delta)

	handle_headbob(delta)

	move_and_slide()

func handle_gravity(delta: float):
	if not is_on_floor():
		if velocity.y >= 0:
			velocity.y -= gravity * delta
		else:
			velocity.y -= gravity * delta * fall_multiplier

func handle_jumping():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

func handle_movement(delta: float):
	var input_dir: Vector2 = Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * lerp_speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * lerp_speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * jump_velocity, delta * 2.0)
		velocity.z = lerp(velocity.z, direction.z * jump_velocity, delta * 2.0)
	
	camera.transform.origin = headbob(bob, bob_frequency, bob_amplitude)

func handle_headbob(delta: float):
	bob += delta * velocity.length() * float(is_on_floor())

func headbob(time: float, freq, amp) -> Vector3:
	var pos: Vector3 = Vector3.ZERO
	pos.y = sin(time * freq) * amp
	
	return pos

func handle_sprinting() -> void:
	if can_sprint and Input.is_action_pressed("sprint"):
		speed = sprinting_speed
	else:
		speed = walking_speed

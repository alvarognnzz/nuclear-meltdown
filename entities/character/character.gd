extends CharacterBody3D

@export var head: Node3D
@export var camera: Camera3D
@export var picking_pivot: Node3D
@export var pickable_camera: Camera3D
@export var placing_raycast: RayCast3D

const walking_speed := 5.0
const sprinting_speed := 6.5

const jump_velocity := 4.5 

const mouse_sensibility := 0.1

const lerp_speed := 10.0

const bob_frequency := 2.0
const bob_amplitude := 0.04
var bob: float = 0.0

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
const fall_multiplier: float = 3

var speed: float = walking_speed
var can_sprint: bool = true

var movement_enabled: bool = true

var reset_global_position: Vector3

var picking: bool = false

var was_on_floor = true
var jump_multiplier = 1


func _ready() -> void:
	reset_global_position = global_position
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Console.add_command("reset", reset_position)
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensibility))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensibility))
		if jump_multiplier < 2:
			head.rotation.x = clamp(head.rotation.x, deg_to_rad(-80), deg_to_rad(60))
	
	elif event.is_action_pressed("escape"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
		elif Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process(_delta: float) -> void:
	pickable_camera.global_transform = camera.global_transform

func _physics_process(delta):
	if movement_enabled:
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
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	var is_now_on_floor = is_on_floor()
	if not was_on_floor and is_now_on_floor:
		var landed_on_jumpable = false
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			if collision.get_collider().is_in_group("jumpable"):
				landed_on_jumpable = true
				if Input.is_action_pressed("ui_accept"):
					velocity.y = jump_velocity * jump_multiplier
					jump_multiplier += 1
					break
				else:
					jump_multiplier = max(0, jump_multiplier - 2)
					velocity.y = jump_velocity * jump_multiplier
		if not landed_on_jumpable:
			jump_multiplier = 1
	was_on_floor = is_now_on_floor


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

func reset_position() -> void:
	global_position = reset_global_position

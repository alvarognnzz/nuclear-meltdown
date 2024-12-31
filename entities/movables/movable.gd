extends StaticBody3D

@export var key: String
@export var input_action: String
@export var action_name: String

@export var interaction_type: Global.InteractionTypes = Global.InteractionTypes.INSTANT

@export var area_3d: Area3D

const GREEN_TRANSPARENT = preload("res://common/materials/green_transparent.tres")
const RED_TRANSPARENT = preload("res://common/materials/red_transparent.tres")

var meshes = []
var collisions = []
var bodies_in_area: Array = []

var moving: bool = false
var character: CharacterBody3D
var placing_raycast: RayCast3D

const SMOOTH_SPEED = 20.0
const NORMAL_THRESHOLD = 0.8

func _ready() -> void:
	character = get_tree().get_first_node_in_group("character")
	placing_raycast = character.placing_raycast
	

func _physics_process(delta: float) -> void:
	if moving:
		update_mesh_materials()
		handle_placing_raycast(delta)

func update_mesh_materials() -> void:
	var material : Material
	if bodies_in_area.size() == 0:
		material = GREEN_TRANSPARENT
	else:
		material = RED_TRANSPARENT

	for mesh in meshes:
		mesh.material_override = material

func handle_placing_raycast(delta: float) -> void:
	if placing_raycast.is_colliding():
		var collision_normal = placing_raycast.get_collision_normal()
		if collision_normal.dot(Vector3.UP) >= NORMAL_THRESHOLD:
			disable_collisions()
			move_toward_target(placing_raycast.get_collision_point(), delta)

func disable_collisions() -> void:
	for collision in collisions:
		collision.disabled = true

func move_toward_target(target_position: Vector3, delta: float) -> void:
	global_position = global_position.move_toward(target_position, SMOOTH_SPEED * delta)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("right_click") and moving and bodies_in_area.size() == 0:
		stop_moving()

func stop_moving() -> void:
	character.picking = false
	for mesh in meshes:
		mesh.material_override = null
	moving = false
	enable_collisions()

func enable_collisions() -> void:
	for collision in collisions:
		collision.disabled = false

func interact() -> void:
	character.picking = true
	moving = true

func can_interact() -> bool:
	return not character.picking

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body not in bodies_in_area and body != self and not body.get_collision_layer_value(3):
		bodies_in_area.append(body)

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body in bodies_in_area and body != self and not body.get_collision_layer_value(3):
		bodies_in_area.erase(body)

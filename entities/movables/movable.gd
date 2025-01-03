class_name Movable
extends Node

@export var area_3d: Area3D
@export var can_interact: bool
@export var pick_audio: AudioStreamPlayer 

const GREEN_TRANSPARENT = preload("res://common/materials/green_transparent.tres")
const RED_TRANSPARENT = preload("res://common/materials/red_transparent.tres")

signal set_moving(value: bool)

var meshes = []
var collisions = []
var bodies_in_area: Array = []

var moving: bool = false
var character: CharacterBody3D
var placing_raycast: RayCast3D

var parent: StaticBody3D

const SMOOTH_SPEED = 20.0
const NORMAL_THRESHOLD = 0.8

const ROTATION_SPEED = 3.0

func _ready() -> void:
	if not get_parent() is StaticBody3D:
		push_error("Movable.gd: Parent must be a StaticBody3D")
	 
	parent = get_parent()
	character = get_tree().get_first_node_in_group("character")
	placing_raycast = character.placing_raycast
	area_3d.body_entered.connect(_on_area_3d_body_entered)
	area_3d.body_exited.connect(_on_area_3d_body_exited)
	meshes = get_all_meshes(parent)
	collisions = get_all_collisions(parent)

func _physics_process(delta: float) -> void:
	if get_tree().get_first_node_in_group("character").picking:
		can_interact = false
	
	if moving:
		update_mesh_materials()
		handle_placing_raycast(delta)
		
		if Input.is_action_pressed("rotate"):
			if Input.is_action_pressed("rotate_backwards"):
				parent.rotation.y += delta * -ROTATION_SPEED
			else:
				parent.rotation.y += delta * ROTATION_SPEED

func get_all_meshes(node: Node) -> Array:
	var meshes = []
	if node is MeshInstance3D:
		meshes.append(node)
	for child in node.get_children():
		meshes += get_all_meshes(child)
	return meshes

func get_all_collisions(node: Node) -> Array:
	var collisions = []
	if node is CollisionShape3D:
		collisions.append(node)
	for child in node.get_children():
		if child != area_3d:
			collisions += get_all_collisions(child)
	return collisions

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
	parent.global_position = parent.global_position.move_toward(target_position, SMOOTH_SPEED * delta)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("right_click") and moving and bodies_in_area.size() == 0:
		stop_moving()

func stop_moving() -> void:
	if pick_audio:
		pick_audio.pitch_scale = .8
		pick_audio.play()
	character.picking = false
	for mesh in meshes:
		mesh.material_override = null
	moving = false
	enable_collisions()
	set_moving.emit(false)
	EventBus.object_being_moved.emit(false)

func enable_collisions() -> void:
	for collision in collisions:
		collision.disabled = false

func interact() -> void:
	if pick_audio:
		pick_audio.pitch_scale = 1
		pick_audio.play()
	character.picking = true
	moving = true
	set_moving.emit(true)
	EventBus.object_being_moved.emit(true)

#func can_interact() -> bool:
	#return not character.picking

# body.get_collision_layer_value(3) detects whether the object is a usable floor or not 
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body not in bodies_in_area and body != self and not body.get_collision_layer_value(3):
		bodies_in_area.append(body)

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body in bodies_in_area and body != self and not body.get_collision_layer_value(3):
		bodies_in_area.erase(body)

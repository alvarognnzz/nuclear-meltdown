class_name Movable
extends "res://entities/movables/movable.gd"

func _ready() -> void:
	super()
	meshes = [$Visuals/Bed]
	collisions = [$CollisionShape3D, $CollisionShape3D2, $CollisionShape3D3]

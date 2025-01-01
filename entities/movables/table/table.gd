extends "res://entities/movables/movable.gd"

func _ready() -> void:
	super()
	meshes = [$Visuals/Table/Cube, $Visuals/Table/Cube_001, $Visuals/Chair/Chair]
	collisions = [$CollisionShape3D, $CollisionShape3D2, $CollisionShape3D3, $CollisionShape3D4, $CollisionShape3D5, $CollisionShape3D6]

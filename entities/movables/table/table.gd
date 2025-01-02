extends "res://entities/movables/movable.gd"

func _ready() -> void:
	super()
	meshes = [$Visuals/Table/Cube, $Visuals/Table/Cube_001, $Visuals/Chair/Chair, $Computer/Sprite3D]
	
	for children in $Visuals/Table.get_children():
		if children is MeshInstance3D:
			meshes.append(children)
	
	for children in $Computer.get_children():
		if children is CollisionShape3D:
			collisions.append(children)
	
	for children in $Computer/Visuals.get_children():
		if children is MeshInstance3D:
			meshes.append(children)
	
	for children in get_children():
		if children is CollisionShape3D:
			collisions.append(children)
	
	for children in $Computer.get_children():
		if children is CollisionShape3D:
			collisions.append(children)

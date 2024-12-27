class_name Pickable
extends "res://entities/pickables/pickable.gd"

@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

func _physics_process(delta: float) -> void:
	if picked:
		mesh_instance_3d.set_layer_mask_value(2, true)
	else:
		mesh_instance_3d.set_layer_mask_value(2, false)

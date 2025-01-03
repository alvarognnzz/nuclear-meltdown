extends RigidBody3D
#class_name Pickable
#extends "res://entities/pickables/pickable.gd"
#
#@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
#
#func _ready() -> void:
	#super()


func _on_interactable_interacted() -> void:
	$Pickable.start_picking()

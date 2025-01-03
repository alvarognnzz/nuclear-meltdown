extends RigidBody3D

func _on_interactable_interacted() -> void:
	$Pickable.start_picking()

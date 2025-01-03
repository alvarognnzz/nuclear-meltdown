extends CSGBox3D

func _on_interactable_interacted() -> void:
	get_tree().get_first_node_in_group("character").global_position = Vector3(-2, 2.5, -12.3)

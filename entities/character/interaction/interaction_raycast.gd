extends RayCast3D

@onready var interaction_label: Label = $"../../../CanvasLayer/InteractionLabel"

func _physics_process(delta: float) -> void:
	if is_colliding():
		var collider = get_collider()
		if collider.has_method("interact"):
			if collider.has_method("can_interact"):
				if collider.can_interact():
					display_interaction_label(collider)
			else:
				display_interaction_label(collider)
			
			if Input.is_action_just_pressed("interact"):
				collider.interact()
		else:
			hide_interaction_label()
	else:
		hide_interaction_label()

func display_interaction_label(collider: Node) -> void:
	interaction_label.text = "[{key}] {name}".format({
		"key": collider.interaction.key,
		"name": collider.interaction.name
	})
	interaction_label.visible = true

func hide_interaction_label() -> void:
	interaction_label.visible = false

extends RayCast3D

@onready var interaction_label: Label = $"../../../CanvasLayer/InteractionUI/InteractionLabel"
@onready var progress_container: MarginContainer = $"../../../CanvasLayer/InteractionUI/ProgressContainer"
@onready var progress_bar: ProgressBar = $"../../../CanvasLayer/InteractionUI/ProgressContainer/CenterContainer/ProgressBar"
	
func _physics_process(delta: float) -> void:
	if is_colliding():
		var collider = get_collider()
		if collider.has_method("interact"):
			handle_interaction(collider)
		else:
			hide_interaction_ui()
	else:
		hide_interaction_ui()

func handle_interaction(collider: Node) -> void:
	if not "interaction_type" in collider:
		hide_interaction_ui()
		return

	display_interaction_label(collider)

	match collider.interaction_type:
		Global.InteractionTypes.INSTANT:
			handle_instant_interaction(collider)
		Global.InteractionTypes.PROGRESS:
			handle_progress_interaction(collider)

func handle_instant_interaction(collider: Node) -> void:
	if collider.has_method("can_interact") and not collider.can_interact():
		return

	if Input.is_action_just_pressed("interact"):
		collider.interact()

func handle_progress_interaction(collider: Node) -> void:
	progress_container.visible = true

	if collider.has_method("can_interact") and not collider.can_interact():
		reset_progress()
		return

	if Input.is_action_pressed("interact"):
		progress_bar.value += collider.progress_speed
		if progress_bar.value >= progress_bar.max_value:
			collider.interact()
			reset_progress()
	else:
		reset_progress()

func reset_progress() -> void:
	progress_bar.value = 0
	progress_container.visible = false

func display_interaction_label(collider: Node) -> void:
	interaction_label.text = "[{key}] {name}".format({
		"key": collider.interaction.key,
		"name": collider.interaction.name
	})
	interaction_label.visible = true

func hide_interaction_ui() -> void:
	interaction_label.visible = false
	reset_progress()

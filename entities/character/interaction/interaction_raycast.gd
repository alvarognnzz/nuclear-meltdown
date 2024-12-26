extends RayCast3D

var interaction_label: Label
var progress_container: MarginContainer
var progress_bar: ProgressBar

func _ready() -> void:
	var canvas_layer = get_tree().get_first_node_in_group("canvas_layer")
	interaction_label = canvas_layer.interaction_label
	progress_container = canvas_layer.progress_container
	progress_bar = canvas_layer.progress_bar

func _physics_process(_delta: float) -> void:
	if is_colliding():
		var collider = get_collider()
		if collider.has_method("interact") and collider.has_method("can_interact") and not collider.can_interact():
			hide_interaction_ui()
		elif collider.has_method("interact"):
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
		hide_interaction_ui()
		return

	if Input.is_action_just_pressed(collider.input_action):
		collider.interact()

func handle_progress_interaction(collider: Node) -> void:
	if collider.has_method("can_interact") and not collider.can_interact():
		reset_progress()
		hide_interaction_ui()
		return

	progress_container.visible = true

	if Input.is_action_pressed(collider.input_action):
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
		"key": collider.key,
		"name": collider.action_name
	})
	interaction_label.visible = true

func hide_interaction_ui() -> void:
	interaction_label.visible = false
	reset_progress()

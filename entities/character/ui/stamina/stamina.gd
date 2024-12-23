extends Control

@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar

@export var character: CharacterBody3D

func _ready() -> void:
	progress_bar.value = 100

func _physics_process(delta: float) -> void:
	if progress_bar.value == 0:
		character.can_sprint = false
	else:
		character.can_sprint = true
	
	if Input.is_action_pressed("sprint"):
		progress_bar.value -= delta * 18
	else:
		if progress_bar.value != 100:
			progress_bar.value += delta * 12

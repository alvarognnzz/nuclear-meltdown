##extends "res://entities/movables/movable.gd"
##
##func _ready() -> void:
	##super()
	##meshes = [$Visuals/Table/Cube, $Visuals/Table/Cube_001, $Visuals/Chair/Chair, $Computer/Sprite3D]
	##
	##for children in $Visuals/Table.get_children():
		##if children is MeshInstance3D:
			##meshes.append(children)
	##
	##for children in $Computer.get_children():
		##if children is CollisionShape3D:
			##collisions.append(children)
	##
	##for children in $Computer/Visuals.get_children():
		##if children is MeshInstance3D:
			##meshes.append(children)
	##
	##for children in get_children():
		##if children is CollisionShape3D:
			##collisions.append(children)
	##
	##for children in $Computer.get_children():
		##if children is CollisionShape3D:
			##collisions.append(children)
#extends StaticBody3D
##
##@onready var animation_player: AnimationPlayer = $Visuals/AnimationPlayer
##@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
#@onready var marker_3d: Marker3D = $Marker3D
#
#@export var interaction_type: Global.InteractionTypes = Global.InteractionTypes.INSTANT
#@export var key: String = "E"
#@export var input_action: String = "interact"
#@export var action_name: String
#
#var using_computer: bool = false
#
#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("escape") and using_computer:
		#using_computer = false
		#EventBus.using_computer.emit(using_computer, marker_3d.global_transform)
#
#func interact() -> void:
	#using_computer = not using_computer
	#EventBus.using_computer.emit(using_computer, marker_3d.global_transform)
	#

extends StaticBody3D

@onready var audio_stream_player: AudioStreamPlayer = $PickAudio
@onready var marker_3d: Marker3D = $Marker3D
@onready var sprite_3d: Sprite3D = $Computer/Sprite3D

var using_computer: bool = false
var moving: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape") and using_computer:
		using_computer = false
		EventBus.using_computer.emit(using_computer, marker_3d.global_transform)

func _on_interactable_interacted() -> void:
	using_computer = not using_computer
	EventBus.using_computer.emit(using_computer, marker_3d.global_transform)

func _on_movable_set_moving(value: bool) -> void:
	moving = value
	sprite_3d.visible = not value

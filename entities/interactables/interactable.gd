class_name Interactable
extends Node

signal interacted

@export var interaction_type: Global.InteractionTypes = Global.InteractionTypes.INSTANT
@export var key: String = "E"
@export var input_action: String = "interact"
@export var progress_speed: float = 1.0
@export var action_name: String
@export var can_interact: bool = true

extends CSGBox3D

@export var interaction_type: Global.InteractionTypes = Global.InteractionTypes.PROGRESS

var progress_speed = 1

var interaction: Dictionary = {
	"key": "E",
	"input": "interact",
	"name": "Interact",
}

func interact() -> void:
	print('interaction')

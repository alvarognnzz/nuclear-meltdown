class_name Movable
extends "res://entities/movables/movable.gd"

@onready var springs_audio: AudioStreamPlayer = $SpringsAudio
const SPRINGS_STREAMS = [
	preload("res://common/sounds/bed/springs1.ogg"),
	preload("res://common/sounds/bed/springs2.ogg")
]

func _ready() -> void:
	super()
	meshes = [$Visuals/Bed]
	collisions = [$CollisionShape3D, $CollisionShape3D2, $CollisionShape3D3]	
	EventBus.landed_on_jumpable.connect(landed_on_jumpable)

func play_springs_audio() -> void:
	springs_audio.stream = SPRINGS_STREAMS[randi() % SPRINGS_STREAMS.size()]
	springs_audio.pitch_scale = randf_range(0.9, 1.3)
	springs_audio.play()

func landed_on_jumpable(jumpable) -> void:
	if jumpable == self:
		play_springs_audio()

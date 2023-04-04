extends Node2D

@onready var audio = $AudioStreamPlayer2D
var death_audio = preload("res://audio/dead.wav")

func _ready():
	audio.stream = death_audio
	audio.play()

func _on_animated_sprite_2d_animation_finished():
	queue_free()
	LevelContext.re_load_scene()

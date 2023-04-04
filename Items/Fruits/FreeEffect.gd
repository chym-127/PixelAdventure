extends Node2D

@onready var audio = $AudioStreamPlayer2D
var audio_src = preload("res://audio/collect.wav")

func _ready():
	audio.stream = audio_src
	audio.play()

func _on_animated_sprite_2d_animation_finished():
	queue_free()

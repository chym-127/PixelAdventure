extends Node2D

@onready var audio = $AudioStreamPlayer2D
var enter_audio = preload("res://audio/enter.wav")
var once = true

func _ready():
	audio.stream = enter_audio

func _on_animated_sprite_2d_animation_finished():
	queue_free()
	
func _process(delta):
	if not audio.playing and once:
		audio.play()
		once = false
	

extends Node2D

enum SPEED {
	SLOW=15,
	NORMAL=10,
	FAST=6
}

enum MODE {
	ROUND,
	LINEAR
}

@onready var path2D = $Path2D
@onready var follow2D = $Path2D/PathFollow2D
@onready var sprite = $Path2D/PathFollow2D/Sprite2D
@export_range(1,3,1) var speed = 3
@export var ROUND  = false

var tween:Tween = null


func _ready():
	follow2D.progress_ratio = 0
	tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(follow2D, 'progress_ratio', 1, 6)
	tween.tween_callback(Callable(self,"tween_callback"))
	tween.set_loops()
	
	print(path2D.curve)

func tween_callback():
	follow2D.progress_ratio = 0

func _physics_process(delta):
	pass
#	sprite.rotate(6*delta)
#	follow2D.set_progress(follow2D.get_progress() + _speed * delta)

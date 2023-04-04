extends Node2D


enum MODE {
	ROUND,
	LINEAR
}

@onready var marker2D = $Marker2D
@export_range(0,360,1) var start_angle = 0
@export_range(1,360,1) var end_angle = 360
@export_range(1,3,1) var speed = 3
@export var ROUND  = false

var current_direction = 1
var current_angle = start_angle

func _ready():
	marker2D.rotation_degrees = start_angle
	if not ROUND:
		var diff = end_angle - start_angle
		var tween = get_tree().create_tween().bind_node(marker2D).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(marker2D, "rotation_degrees", end_angle, diff / (speed*60))
		tween.tween_property(marker2D, "rotation_degrees", start_angle, diff / (speed*60))
		tween.set_loops()
		tween.play()
	
func _physics_process(delta):
	if ROUND:
		marker2D.rotate(speed*delta)



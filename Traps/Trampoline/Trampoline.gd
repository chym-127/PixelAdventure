extends StaticBody2D

enum {
	IDLE,
	JUMP
}

@onready var animation = $AnimationPlayer

var state = IDLE

func _physics_process(delta):
	match state:
		IDLE:
			animation.play("Idle")
		JUMP:
			animation.play("Jump")



func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Jump":
		state = IDLE


func _on_booster_area_entered(area):
	state = JUMP

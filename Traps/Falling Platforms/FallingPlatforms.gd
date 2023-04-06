extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

enum {
	IDLE,
	RUN
}

var state = RUN
@onready var animation = $AnimationPlayer
@onready var timer = $Timer


func _physics_process(delta):
	match state:
		RUN:
			animation.play("Run")
		IDLE:
			animation.play("Idle")
			if not is_on_floor():
				velocity.y += gravity * delta
				move_and_slide()
			if is_on_floor():
				queue_free()

func _on_timer_timeout():
	state = IDLE

func _on_booster_area_entered(area):
	timer.start(0.3)

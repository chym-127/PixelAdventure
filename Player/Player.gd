extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -320.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var DeathEffect = preload("res://Player/death_effect.tscn")
@onready var sprite = $Sprite2D
@onready var amimation = $AnimationPlayer
@onready var audio = $AudioStreamPlayer2D

var jump_audio = preload("res://audio/jump.wav")

func _ready():
	audio.stream = jump_audio

enum {
	IDLE,
	RUN,
	JUMP,
	DOUBLE_JUMP,
	FALL,
	WALLJUMP
}

var state = IDLE
var can_double_jump = false
var can_jump = true

func _physics_process(delta):
#	首先判断是否是WallJump 状态
	var flag = is_on_wall_only()
	if flag:
		if get_wall_normal().x == -Input.get_axis("ui_left", "ui_right"):
			velocity.x = move_toward(velocity.x, 0, SPEED)
			state = WALLJUMP
			if Input.is_action_just_pressed("ui_accept") and state != DOUBLE_JUMP:
				velocity.y = JUMP_VELOCITY 
		else:
			if state != DOUBLE_JUMP and state != JUMP:
				state = FALL
			
	var direction = Input.get_axis("ui_left", "ui_right")
		
#	如果玩家在地板之上并且有方向键被按下改变为RUN状态
	if is_on_floor():
		state = RUN
	
#	监听跳的事件
	if Input.is_action_just_pressed("ui_accept") and can_jump:
		audio.play()
		if can_double_jump:
			can_jump = false
			can_double_jump = false
			state = DOUBLE_JUMP
			velocity.y = JUMP_VELOCITY * 0.85
		else:
			can_double_jump = true
			state = JUMP
			velocity.y = JUMP_VELOCITY 
		
	if not is_on_floor() and state != WALLJUMP:
		if state != DOUBLE_JUMP:
			if velocity.y < 0:
				state = JUMP
			else:
				state = FALL
		velocity.y += gravity * delta
	
	var anima_name = ""
	match state:
		RUN:
			anima_name = move_state(direction)
		JUMP:
			jump_state(direction)
			anima_name = "JUMP"
		FALL:
			fall_state(direction)
			anima_name = "FALL"
		DOUBLE_JUMP:
			double_jump_state(direction)
			anima_name = "DOUBLEJUMP"
		WALLJUMP:
			wall_jump_state(direction)
			anima_name = "WALLJUMP"
	
	set_animation(anima_name)
	change_facing(velocity.x)
	flag = move_and_slide()
	if !flag:
		if state == WALLJUMP:
			state = FALL
		
		
	
func move(direction,scale=1):
	if direction:
		velocity.x = direction * SPEED * scale
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func move_state(direction):
	can_jump = true
	can_double_jump = false
	move(direction)
	if direction:
		return "RUN"
	else: 
		return "IDLE"

func jump_state(direction):
	move(direction)

func fall_state(direction):
	move(direction)

func double_jump_state(direction):
	move(direction)
	
func wall_jump_state(direction):
	move(direction,0.5)
	can_jump = true
	can_double_jump = false
	velocity.y = 15

func change_facing(x):
	if x > 0:
		sprite.flip_h = false
	if x < 0:
		sprite.flip_h = true 

func set_animation(anima_name):
	amimation.play(anima_name)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "WALLJUMP":
		state = JUMP
	if anim_name == "DOUBLEJUMP":
		state = FALL
		

func death():
	var deathEffect = DeathEffect.instantiate()
	deathEffect.global_position = global_position
	get_tree().current_scene.add_child(deathEffect)
	queue_free()

func _on_player_hurt_box_body_entered(body):
#	地刺
	if body.name == "Traps":
		death()

func _on_player_hurt_box_area_entered(area):
	death()

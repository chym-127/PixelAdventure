extends Node2D

enum BG{
	BLUE,
	BROWN,
	GRAY,
	GREEN,
	PINK,
	PURPLE,
	YELLOW
}

var BlueBg = preload("res://Background/Blue.png")
var BrownBg = preload("res://Background/Brown.png")
var GrayBg = preload("res://Background/Gray.png")
var GreenBg = preload("res://Background/Green.png")
var PinkBg = preload("res://Background/Pink.png")
var PurpleBg = preload("res://Background/Purple.png")
var YellowBg = preload("res://Background/Yellow.png")

@onready var sprite = $Sprite2D
@export var IS_RANDOM = false
@export var bg:BG = BG.BLUE 
@export_range(-0.5,0.5,0.1) var speed_x:float = 0.0
@export_range(-0.5,0.5,0.1) var speed_y:float = -0.5

func _ready():
	if IS_RANDOM:
		var random_generator = RandomNumberGenerator.new()
		random_generator.randomize()
		bg = random_generator.randi_range(0,5)
		speed_x = random_generator.randf_range(-0.5,0.5)
		speed_y = random_generator.randf_range(-0.5,0.5)
	sprite.material.set_shader_parameter("speed_x",speed_x)
	sprite.material.set_shader_parameter("speed_y",speed_y)
	match bg:
		BG.BLUE:
			sprite.texture = BlueBg
		BG.BROWN:
			sprite.texture = BrownBg
		BG.GRAY:
			sprite.texture = GrayBg
		BG.GREEN:
			sprite.texture = GreenBg
		BG.PINK:
			sprite.texture = PinkBg
		BG.PURPLE:
			sprite.texture = PurpleBg
		BG.YELLOW:
			sprite.texture = YellowBg

extends Node2D

enum EVENT {
	PLAY,
	LEVELS,
	LEVEL,
	HELP
}

@onready var sprite = $Sprite
@onready var border = $Border

@export var event:EVENT = EVENT.PLAY
@export var level = 1

func active():
	border.visible = true
	
func unactive():
	border.visible = false
	
func exec():
	match event:
		EVENT.PLAY:
			SceneContext.load_level_scene(1)
		EVENT.LEVELS:
			SceneContext.load_levels_scene()
			pass
		EVENT.HELP:
			pass
	

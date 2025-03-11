extends Node2D


@onready var foods = $Foods
@export var level_num:int = 1
var food_total = 0
var level_string = "res://Levels/level_%s.tscn"

func _ready():
	if foods:
		food_total = foods.get_child_count()
	LevelContext.connect("food_changed",Callable(self,"food_free"))

func food_free():
	food_total -= 1
	if food_total == 0:
		next_level()

func next_level():
	var level_scene = load(level_string % (level_num+1))
	get_tree().change_scene_to_packed(level_scene)  
	

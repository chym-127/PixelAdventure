extends Node2D


@onready var foods = $Foods
var food_total = 0
@export var level_num:int = 1

func _ready():
	food_total = foods.get_child_count()
	LevelContext.connect("food_changed",Callable(self,"food_free"))


func food_free():
	food_total -= 1
	if food_total == 0:
		next_level()

func next_level():
	print("next_level")
	


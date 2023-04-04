extends Node2D

var FreeEffect = preload("res://Items/Fruits/free_effect.tscn")

func _on_food_hurt_area_entered(area):
	var freeEffect = FreeEffect.instantiate()
	freeEffect.global_position = global_position
	get_tree().current_scene.add_child(freeEffect)
	LevelContext.eat_food()
	queue_free()

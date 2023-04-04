extends Node


signal food_changed

func eat_food():
	emit_signal("food_changed")


func re_load_scene():
	get_tree().reload_current_scene()

extends Node

var MenuScene = preload("res://UI/MainMenu.tscn")
var LevelsScene = preload("res://UI/SelectLevel.tscn")
var level_string = "res://Levels/level_%s.tscn"

func load_menu_scene():
	get_tree().change_scene_to_packed(MenuScene)
	
func load_levels_scene():
	get_tree().change_scene_to_packed(LevelsScene)


func load_level_scene(level):
	var level_scene = load(level_string % level)
	get_tree().change_scene_to_packed(level_scene)
	

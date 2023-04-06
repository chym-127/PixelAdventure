extends Node2D


@onready var button_list = $button_list
@onready var total = button_list.get_child_count()
@onready var buttons = []
var current_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var total = button_list.get_child_count()
	for idx in total:
		buttons.append(button_list.get_child(idx))
	buttons[current_index].active()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		buttons[current_index].exec()
	else:
		var new_index = current_index
		if Input.is_action_just_pressed("ui_down"):
			if new_index < total-1:
				new_index += 1
			else:
				new_index = 0
		if Input.is_action_just_pressed("ui_up"):
			if new_index > 0:
				new_index -= 1
			else:
				new_index = total-1
		if current_index != new_index:
			buttons[current_index].unactive()
			current_index = new_index
			buttons[current_index].active()

extends GridContainer


var cols:int = 2
var rows:int = 5

var cur:Vector2 = Vector2(0,0)
var cur_button:Button
var buttonList:Array = []
var key_includes = ["Down","Up","Left","Right"]


func _ready() -> void:
	columns = rows
	var level_btn_scene = load("res://UI/level-btn.tscn")
	for i in range(cols*rows):
		var button = level_btn_scene.instantiate()
		button.set_idx(i+1)
		buttonList.push_back(button)
		add_child(button)
	cur_button=buttonList[0]
	cur_button.active()
		
func _input(event):
	var key_code = event.as_text()
	if (key_code == "Enter" || key_code == "Space") && event.pressed:
		print(key_code)
		loadscene()
	if key_code in key_includes && event.pressed:
		if key_code == "Down":
			cur.x += 1
		if key_code == "Up":
			cur.x -= 1
		if key_code == "Left":
			cur.y -= 1
		if key_code == "Right":
			cur.y += 1
		if cur.x < 0:
			cur.x = cols-1
		if cur.x >= cols:
			cur.x = 0
		if cur.y < 0:
			cur.y = rows-1
		if cur.y >= rows:
			cur.y = 0
		var idx = cur.x*rows + cur.y
		cur_button.unactive()
		cur_button = buttonList[int(idx)]
		if cur_button:
			cur_button.active()
		
func loadscene():
	var idx = cur.x*rows + cur.y;
	SceneContext.load_level_scene(int(idx)+1)

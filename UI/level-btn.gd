extends Button

@onready var baseTexture = $BaseTexture
@onready var selectedTexture = $SelectedTexture

var btn_icon = "res://Menu/Levels/%s.png"
var idx: String
func set_idx(idx_: int):
	if idx_ < 10:
		idx = "0"+str(idx_)
	else:
		idx = str(idx_)
	

func _ready():
	if baseTexture:
		baseTexture.texture = load(btn_icon % idx)
		
		
func active():
	selectedTexture.visible = true
	
func unactive():
	selectedTexture.visible = false

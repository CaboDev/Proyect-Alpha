extends Control

@export var scae : float
@export var Button_Index : int
var max_B_Index
var Y_posision_hipotetica

# Called when the node enters the scene tree for the first time.
func _ready():
	scae = 244
	Y_posision_hipotetica = position.y
	Button_Index = get_child_count()
	max_B_Index = Button_Index

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_down") && Button_Index > 1:
		Button_Index -= 1
		Y_posision_hipotetica -= scae
		var twen = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
		twen.tween_property(self, "position", Vector2(144, Y_posision_hipotetica), 0.4)
		
		
	elif Input.is_action_just_pressed("ui_up") && Button_Index < max_B_Index:
		Button_Index += 1
		Y_posision_hipotetica += scae
		var twen = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
		twen.tween_property(self, "position", Vector2(144, Y_posision_hipotetica), 0.4)
		
		

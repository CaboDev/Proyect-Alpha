extends TextureButton

var audio = AudioStreamPlayer.new()
const NOTHIN_1 = preload("res://assets/Boss_Rush_Mode/nothin1.png")
const A = preload("res://assets/Boss_Rush_Mode/A.png")
signal activ_Focus(Boss : String)
@export var nivel : PackedScene
@export var grab_the_focus : bool
@export var Scale_new : float = 1
@export_enum("Flame", "Gusanos", "ojo", "araña", "digital") var boss : String
# Called when the node enters the scene tree for the first time.

func _ready():
	Save.add_child(audio)
	audio.pitch_scale = 1
	
	focus_entered.connect(_on_focus_entered)
	focus_exited.connect(_on_focus_exited)
	pressed.connect(_on_pressed)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
	var twen = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	if grab_the_focus == true:
		grab_focus()
		twen.tween_property(self, "scale", Vector2(Scale_new, Scale_new), 0.4)
	else:
		twen.tween_property(self, "scale", Vector2(0.8, 0.8), 0.4)

func _on_pressed():
	audio.stream = load("res://assets/auds/kenney_interface-sounds/Audio/confirmation_001.ogg")
	audio.play()




func _on_focus_entered():
	audio.stream = load("res://assets/auds/kenney_interface-sounds/Audio/drop_002.ogg")
	audio.play()
	var twen = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	twen.tween_property(self, "scale", Vector2(Scale_new, Scale_new), 0.4)
	emit_signal("activ_Focus", boss)


func _on_focus_exited():
	var twen = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	twen.tween_property(self, "scale", Vector2(0.8, 0.8), 0.4)




func _on_mouse_entered():
	audio.stream = load("res://assets/auds/kenney_interface-sounds/Audio/drop_002.ogg")
	audio.play()
	var twen = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	twen.tween_property(self, "scale", Vector2(Scale_new, Scale_new), 0.4)
	emit_signal("activ_Focus", boss)


func _on_mouse_exited():
	var twen = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	twen.tween_property(self, "scale", Vector2(0.8, 0.8), 0.4)

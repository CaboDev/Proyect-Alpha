extends Button

var audio = AudioStreamPlayer.new()
const NOTHIN_1 = preload("res://assets/Boss_Rush_Mode/nothin1.png")
const A = preload("res://assets/Boss_Rush_Mode/A.png")
signal activ_Focus(Boss : String)
@export var nivel : PackedScene
@export var grab_the_focus : bool
@export_enum("Flame", "Gusanos", "ojo", "araña", "digital", "octopus", "joker") var boss : String
# Called when the node enters the scene tree for the first time.
@export_category("Solo La Animacion")
@export var Max_Scale : Vector2 = Vector2(1, 1)
@export var Min_Scale : Vector2 = Vector2(0.5, 0.5)
@export var no_compuesto : bool

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and no_compuesto == true:
		var mensaje = tr($Label.text)
		var caracteres_del_label : int = mensaje.length() 
		if  caracteres_del_label > 14:
			var maximo_tamaño : Vector2 = Vector2(0.07142, 0.0657143)
			caracteres_del_label -= 14
			$Label.scale -= maximo_tamaño* caracteres_del_label
			$Label.size.x += 29 * caracteres_del_label 
			no_compuesto = false

func _ready():
	focus_entered.connect(_on_focus_entered)
	focus_exited.connect(_on_focus_exited)
	
	
	Save.add_child(audio)
	audio.pitch_scale = 1
	
	var twen = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	if grab_the_focus == true:
		grab_focus()
		twen.tween_property(self, "scale", Vector2(1, 1), 0.4)
	else:
		twen.tween_property(self, "scale", Vector2(0.5, 0.5), 0.4)
		
	_on_focus_exited()

func _on_pressed():
	audio.stream = load("res://assets/auds/kenney_interface-sounds/Audio/confirmation_001.ogg")
	audio.play()
	get_tree().change_scene_to_packed(nivel)



func _on_focus_entered():
	z_index +=1
	audio.stream = load("res://assets/auds/kenney_interface-sounds/Audio/drop_002.ogg")
	audio.play()
	var twen = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	twen.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	twen.tween_property(self, "scale", Max_Scale, 0.4)
	emit_signal("activ_Focus", boss)
	


func _on_focus_exited():
	z_index -=1
	var twen = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	twen.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	twen.tween_property(self, "scale",Min_Scale, 0.4)

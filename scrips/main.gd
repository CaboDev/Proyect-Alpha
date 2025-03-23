extends Node2D

var siguiente_escena 

# Called when the node enters the scene tree for the first time.
func _ready():
	
	print(Save.settings.pantalla_completa)
	$Control/OptionButton.selected = Save.settings.pantalla_completa
	$Control/ColorPickerButton.color = Save.settings.color_favorito
	cambio_pantalla()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	$select_mode/Boss_rush.grab_focus()
	$AnimationPlayer.play("new_animation")


func _on_option_button_item_selected(index):
	Save.settings.pantalla_completa = index
	Save.save_settings()
	cambio_pantalla()

func cambio_pantalla():
	if Save.settings.pantalla_completa == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if Save.settings.pantalla_completa == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)


func _on_color_picker_button_color_changed(color):
	Save.settings.color_favorito = color
	Save.save_settings()


func _on_config_pressed():
	$config/botones/Button.grab_focus()
	_on_config_back("ir_config_control_2", false)


func _on_traduccion_pressed() -> void:
	$Traduction_s._recibir_focus()
	_on_config_back("ir_config_trad_2", false)

func _on_traduction_s_back() -> void:
	$Control/config.grab_focus()
	_on_config_back("ir_config_trad_2", true)


func _on_config_back(anim, regreso):
	if regreso == true:
		$AnimationPlayer.play_backwards(anim)
		$Control/AudioStreamPlayer.play()
	else:
		$AnimationPlayer.play(anim, -1, 1 , regreso)
	if anim == "ir_config_control" or anim == "select_mode":
		if regreso == true:
			$select_mode/play.grab_focus()


func _on_configuracion_pressed():
	$Control/config.grab_focus()
	_on_config_back("ir_config_control", false)


func _on_extras_pressed():
	_on_config_back("ir_extras", false)


func _on_logros_pressed():
	if !$select_mode/CanvasLayer/AnimationPlayer.is_playing():
		siguiente_escena = "res://esenas/wordls/sub worls/word_1.tscn"
		$select_mode/CanvasLayer/AnimationPlayer.play("0.5")


func _on_atras_settinz_pressed():
	_on_config_back("ir_config_control", true)


func _on_play_pressed():
	$select2mode/Boss_rush.grab_focus()
	_on_config_back("select_mode", false)


func _on_boss_rush_pressed():
	_on_config_back("select_sub_mode", false)
	$Control2/freeplay.grab_focus()


func _on_history_pressed():
	if !$select_mode/CanvasLayer/AnimationPlayer.is_playing():
		siguiente_escena = "res://esenas/wordls/sub worls/word_1.tscn"
		$select_mode/CanvasLayer/AnimationPlayer.play("0.5")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "0.5":
		get_tree().change_scene_to_file(siguiente_escena)


func _on_freeplay_pressed():
	siguiente_escena = "res://esenas/level_selector.tscn"
	$select_mode/CanvasLayer/AnimationPlayer.play("0.5")


func _on_config_control_back(anim: String, regreso: bool) -> void:
	$Control/config.grab_focus()
	_on_config_back(anim,regreso)
	

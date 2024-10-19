extends Control

var esperando = false
signal back(anim : String, regreso : bool)
var iz = false
var der = false
var up = false
var donw = false
var disparar = false
var saltar = false
var curar = false
var apuntar = false
var dash = false
var cambiar_disparo = false
var ulti_1 = false
var ulti_2 = false



var intup

func _input(event):
	if event is InputEventJoypadButton or JOY_AXIS_TRIGGER_RIGHT or JOY_AXIS_TRIGGER_LEFT:
		if esperando == true:
			cambio(event)
			esperando = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func actualizar_imagenes():
	$botones/AnimatedSprite2D._ready()
	$botones/AnimatedSprite2D2._ready()
	$botones/AnimatedSprite2D3._ready()
	$botones/AnimatedSprite2D4._ready()
	$botones/AnimatedSprite2D5._ready()
	$botones/AnimatedSprite2D6._ready()
	$botones/AnimatedSprite2D7._ready()
	$botones/AnimatedSprite2D8._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if esperando == true:
		$botones/VBoxContainer.modulate = Color.DARK_SLATE_GRAY
	else:
		$botones/VBoxContainer.modulate = Color.WHITE

func cambio(event):
	if event.is_pressed():
		if event is InputEventJoypadButton:
			Change_key(intup, event)
			Save.control_settins[intup]["number"] = InputMap.action_get_events(intup)[0].button_index
			Save.control_settins[intup]["type"] = "Boton"
			
		elif event is InputEventJoypadMotion:
			if event.axis == 5:
				Change_key(intup, event)
				Save.control_settins[intup]["type"] = "axis"
				Save.control_settins[intup]["number"] = InputMap.action_get_events(intup)[0].axis
			elif event.axis == 4:
				Change_key(intup, event)
				Save.control_settins[intup]["type"] = "axis"
				Save.control_settins[intup]["number"] = InputMap.action_get_events(intup)[0].axis
			
		Save.save_control_settins()
		print(Save.control_settins[intup])

func Change_key(Input_action, input_event) -> void:
	InputMap.action_erase_events(Input_action)
	InputMap.action_add_event(Input_action,input_event)
	Save.save_control_settins()
	
	actualizar_imagenes()

func _on_pressed():
	esperando = true
func _on_der_pressed():
	intup = "ui_right"
func _on_iz_pressed():
	intup = "ui_left"
func _on_up_pressed():
	intup = "ui_up"
func _on_down_pressed():
	intup = "ui_down"
func _on_disparar_pressed():
	intup = "z"
func _on_apuntar_pressed():
	intup = "apuntar"
func _on_cambiar_disparo_pressed():
	intup = "cambio_de_arma"
func _on_curar_pressed():
	intup = "cure"
func _on_saltar_pressed():
	intup = "saltar"
func _on_dash_pressed():
	intup = "humo"
func _on_ulti_pressed():
	intup = "ulti_1"
func _on_ulti_2_pressed():
	intup = "ulti_2"


func _on_button_pressed():
	emit_signal("back","ir_config_control_2", true)


func _on_reestablecer_pressed():
	$Panel.iniciar()


func _on_panel_si():
	$botones/VBoxContainer/z.grab_focus()
	InputMap.load_from_project_settings()
	Save._reinicio_de_controles()
	Save.save_control_settins()
	
	actualizar_imagenes()

extends Node

const SAVEFILE ="user://SAVEFILE.save"
const OPTIONS_SETTINNGS ="user://OPTIONS_SETTINNGS.save"
const CONTROL_SETTINS = "user://CONTROL_SETTINS.save"

var hard_mode = false

var Mode_boss_rush = false

var control_settins = {
	"primera vez" :  true,
	
	"z" :  {
		"type" : "button",
		"number" : 0
	},
	"saltar" :  {
		"type" : "button",
		"number" : 0
	},
	"humo" :  {
		"type" : "button",
		"number" : 0
	},
	"apuntar" :  {
		"type" : "button",
		"number" : 0
	},
	"cambio_de_arma" : {
		"type" : "button",
		"number" : 0
	},
	"cure" :  {
		"type" : "button",
		"number" : 0
	},
	"ulti_1" :  {
		"type" : "button",
		"number" : 0
	},
	"ulti_2" :  {
		"type" : "button",
		"number" : 0
	}
}

var settings = {
	"pantalla_completa" : 0,
	"color_favorito" : Color(0,1,1)
}

var game_data = {
	"primera vez" :  true,
	
	"AMULETO_EQUIPADO" : "Amuleto_maniobra_evasiva",
	"ARMA_EQUIPADA" : "Arma_basica",
	"ARMA_EQUIPADA2" : "Arma_basica",
	"ULTI_EQUIPADA" : "Explosion",
	"ULTI_EQUIPADA2" : "Explosion",
	
	"Amuleto_5_vidas" : false,
	"Amuleto_50_mas daño" : false,
	"Amuleto_escudo_orbital" : false,
	"Amuleto_maniobra_evasiva" : false,
	"Amuleto_Curacion_hollow_knight" : false,
	
	"bomba" : false,
	"carga" : false,
	"Arma_basica" : false,
	"Arma_laser" : false,
	"Arma_laserx3" : false,
	"Arma_basicax3" : false,
	
	"Nivel 1" : true,
	"Boss 1" : false,
	"Nivel 2" : false,
	"Boss 2" : false,
	"Nivel 3" : false,
	"Boss 3" : false,
	"Nivel 4" : false,
	"Final boss" : false
}
# Called when the node enters the scene tree for the first time.
func _ready():
	
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	load_data()
	load_settings()
	load_control_settins()
	
	if control_settins["primera vez"] == true:
		_reinicio_de_controles()
		control_settins["primera vez"] = false
	else:
		print(control_settins["z"])
		Change_key("z", control_settins["z"])
		Change_key("saltar", control_settins["saltar"])
		Change_key("humo", control_settins["humo"])
		Change_key("cure", control_settins["cure"])
		Change_key("apuntar", control_settins["apuntar"])
		Change_key("cambio_de_arma", control_settins["cambio_de_arma"])
		Change_key("ulti_1", control_settins["ulti_1"])
		Change_key("ulti_2", control_settins["ulti_2"])

func _reinicio_de_controles():
	control_settins["z"]["number"] = InputMap.action_get_events("z")[0].axis
	control_settins["z"]["type"] = "axis"
	Change_key("z", control_settins["z"])
	
	control_settins["saltar"]["number"] = InputMap.action_get_events("saltar")[0].button_index
	control_settins["saltar"]["type"] = "Boton"
	Change_key("saltar", control_settins["saltar"])
	
	control_settins["humo"]["number"] = InputMap.action_get_events("humo")[0].button_index
	control_settins["humo"]["type"] = "Boton"
	Change_key("humo", control_settins["humo"])
	
	control_settins["apuntar"]["number"] = InputMap.action_get_events("apuntar")[0].axis
	control_settins["apuntar"]["type"] = "axis"
	Change_key("apuntar", control_settins["apuntar"])
	
	control_settins["cambio_de_arma"]["number"] = InputMap.action_get_events("cambio_de_arma")[0].button_index
	control_settins["cambio_de_arma"]["type"] = "Boton"
	Change_key("cambio_de_arma", control_settins["cambio_de_arma"])
	
	control_settins["cure"]["number"] = InputMap.action_get_events("cure")[0].button_index
	control_settins["cure"]["type"] = "Boton"
	Change_key("cure", control_settins["cure"])
	
	control_settins["ulti_1"]["number"] = InputMap.action_get_events("ulti_1")[0].button_index
	control_settins["ulti_1"]["type"] = "Boton"
	Change_key("ulti_1", control_settins["ulti_1"])
	
	control_settins["ulti_2"]["number"] = InputMap.action_get_events("ulti_2")[0].button_index
	control_settins["ulti_2"]["type"] = "Boton"
	Change_key("ulti_2", control_settins["ulti_2"])
	


func load_data():
	var file = FileAccess.open(SAVEFILE,FileAccess.READ)
	if file == null:
		save_data()
	else:
		game_data = file.get_var()
	file = null

func save_data():
	var file = FileAccess.open(SAVEFILE,FileAccess.WRITE)
	file.store_var(game_data)
	file = null


func load_settings():
	var file = FileAccess.open(OPTIONS_SETTINNGS,FileAccess.READ)
	if file == null:
		save_settings()
	else:
		settings = file.get_var()
	file = null

func save_settings():
	var file = FileAccess.open(OPTIONS_SETTINNGS,FileAccess.WRITE)
	file.store_var(settings)
	file = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func load_control_settins():
	var file = FileAccess.open(CONTROL_SETTINS,FileAccess.READ)
	if file == null:
		save_control_settins()
	else:
		control_settins = file.get_var()
		
		
		
	file = null

func Change_key(Input_action, input_event) -> void:
	var eventt_number = input_event["number"]
	var evento_a = InputEventJoypadMotion.new()
	var evento_b = InputEventJoypadButton.new()
	
	evento_a.axis = eventt_number
	evento_b.button_index = eventt_number
	
	if input_event["type"] == "axis":
		InputMap.action_erase_events(Input_action)
		InputMap.action_add_event(Input_action,evento_a)
	else:
		InputMap.action_erase_events(Input_action)
		InputMap.action_add_event(Input_action,evento_b)

func save_control_settins():
	var file = FileAccess.open(CONTROL_SETTINS,FileAccess.WRITE)
	file.store_var(control_settins)
	file = null

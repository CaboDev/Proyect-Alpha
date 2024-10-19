extends Node2D

var Nivel_1 = Save.game_data["Nivel 1"]
var Nivel_2 = Save.game_data["Nivel 2"]
var Nivel_3 = Save.game_data["Nivel 3"]
var Nivel_4 = Save.game_data["Nivel 4"]

const BOSSES = {
	"Flame" : {
		"name" : "Flame",
		"descripcion" : "un mercenario",
	},
	"Gusanos" : {
		"name" : "Gusanos de lava",
		"descripcion" : "gusanos",
	},
	"ojo" : {
		"name" : "Ojo de Dios",
		"descripcion" : "una camara mecanica",
	},
	"araña" : {
		"name" : "Sp1der",
		"descripcion" : "una araña mecanica",
	},
	"digital" : {
		"name" : "Digital Crusher",
		"descripcion" : "una camara mecanica",
	},
	"octopus" : {
		"name" : "octopus",
		"descripcion" : "octopus",
	}
}

signal back(anim : String)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("x"):
		if Save.hard_mode == false:
			$Control/description/Ui6.frame = 1
			Save.hard_mode = true
		elif Save.hard_mode == true:
			$Control/description/Ui6.frame = 0
			Save.hard_mode = false





func _on_nivel_1_activ_focus(Boss):
	%name.text = BOSSES[Boss]["name"]
	%des.text = BOSSES[Boss]["descripcion"]

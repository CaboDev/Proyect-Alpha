extends TextureButton

@export_enum("gun", "gun_2", "objeto","ulti","ulti2") var type : String

@export_enum("Amuleto_5_vidas", "Amuleto_50_mas daño",
 "Amuleto_escudo_orbital", "Amuleto_maniobra_evasiva","Amuleto_Curacion_hollow_knight") var objeto : String

@export_enum("Arma_basica", "Arma_laser",
"Arma_laserx3", "Arma_basicax3", "bomba", "carga") var gun : String

@export_enum("Explosion", "Superior_1") var ulti : String

@onready var papa = get_tree().get_nodes_in_group("menu_cambios")[0]

func _ready():
	var timer = get_tree().create_timer(0.5)
	timer.connect("timeout",scan)
	scan()
	
	connect("focus_entered",focus_entered)
	connect("focus_exited",focus_exited)


func scan():
	if type == "objeto":
		if papa.equiped.object == objeto:
			self_modulate = Color(0.266662, 0.266666, 0.266666, 0.7196)
		else:
			self_modulate = Color.WHITE
	elif type == "gun":
		if papa.equiped.gun == gun:
			self_modulate = Color(0.266662, 0.266666, 0.266666, 0.7196)
		else:
			self_modulate = Color.WHITE
	elif type == "gun_2":
		if papa.equiped.gun_2 == gun:
			self_modulate = Color(0.266662, 0.266666, 0.266666, 0.7196)
		else:
			self_modulate = Color.WHITE
	elif type == "ulti":
		if papa.equiped.ulti == ulti:
			self_modulate = Color(0.266662, 0.266666, 0.266666, 0.7196)
		else:
			self_modulate = Color.WHITE
	elif type == "ulti_2":
		if papa.equiped.ulti_2 == ulti:
			self_modulate = Color(0.266662, 0.266666, 0.266666, 0.7196)
		else:
			self_modulate = Color.WHITE

func focus_entered():
	$Control.show()

func focus_exited():
	$Control.hide()

func _on_pressed():
	get_tree().get_nodes_in_group("m")[0].grab_focus()
	if type == "objeto":
		Save.game_data.AMULETO_EQUIPADO = objeto
		
	elif type == "gun":
		Save.game_data.ARMA_EQUIPADA = gun
		
	elif type == "gun_2":
		Save.game_data.ARMA_EQUIPADA2 = gun
		
	elif type == "ulti":
		Save.game_data.ULTI_EQUIPADA = ulti
	elif type == "ulti_2":
		Save.game_data.ULTI_EQUIPADA2 = ulti
	
	Save.save_data()
	


func _input(event):
	if event.is_action_pressed("ui_accept"):
		var timer = get_tree().create_timer(0.2)
		timer.connect("timeout",scan)
		




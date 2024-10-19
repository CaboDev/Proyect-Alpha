extends Control

@export var activa = false
var muerto = true
var equiped = {
	"object" : null,
	"gun" : null,
	"gun_2" : null,
	"ulti" : null,
	"ulti_2" : null
}

# Called when the node enters the scene tree for the first time.
func _ready():
	var color = Save.settings.color_favorito-Color.GRAY
	
	

func _input(event):
	if activa == true:
		var d = Input.get_axis("Nav_-1","Nav_1")
		if d:
			$p/Button.grab_focus()
			$p/TabContainer.current_tab += d
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("habilites"):
		if muerto == true:
			aqui()
	equiped.object = Save.game_data.AMULETO_EQUIPADO
	equiped.gun = Save.game_data.ARMA_EQUIPADA
	equiped.gun_2 = Save.game_data.ARMA_EQUIPADA2
	equiped.ulti = Save.game_data.ULTI_EQUIPADA
	equiped.ulti_2 = Save.game_data.ULTI_EQUIPADA2

func aqui():
	$AnimationPlayer.play("VENIR")
	$p/Button.grab_focus()

func fuera():
	$AnimationPlayer.play("IRSE")
	get_tree().get_nodes_in_group("mi")[0].grab_focus()


func _on_button_pressed():
	fuera()
	


func _on_bomba_pressed():
	pass # Replace with function body.

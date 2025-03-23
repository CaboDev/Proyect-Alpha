extends Node2D

var bala = preload("res://esenas/plataformer/joker/cartas.tscn")
const CARD_ATTACK = preload("res://esenas/plataformer/joker/card_attack.tscn")

@export var en_Braxaso : bool
@export var B_or_W : int
var bullet_spe = 1000
@export var vida : float = 1000
signal ko
@onready var playback :AnimationNodeStateMachinePlayback = $Boss/AnimationTree.get("parameters/playback")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Boss/AnimationTree.active = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	%Nodo_master_de_obs.look_at(get_tree().get_first_node_in_group("pliyir").global_position)


func lanzar_cartas(color : String):
	var b = CARD_ATTACK.instantiate()
	b.color_main = color
	b.global_position = get_tree().get_first_node_in_group("pliyir").global_position
	get_parent().call_deferred("add_child", b)
	

func _retraer_Brazaso():
	pass

func _Brazaso_Ya():
	pass


func _Brazaso_Terminado():
	pass

func _Disparar_de_la_mano():
	var rng = randi_range(1,2)
	var tipo : String
	var grupo : String
	
	
	match rng:
		1:tipo = "trebol"
		2:tipo = "diamante"
	
	var b1 = bala.instantiate()
	grupo = "Punto_origen"
	b1.Type = tipo
	b1.global_position = get_tree().get_first_node_in_group(grupo).global_position
	b1.global_rotation = get_tree().get_first_node_in_group(grupo).global_rotation
	var b2 = bala.instantiate()
	grupo = "Punto_origen2"
	b2.Type = tipo
	b2.global_position = get_tree().get_first_node_in_group(grupo).global_position
	b2.global_rotation = get_tree().get_first_node_in_group(grupo).global_rotation
	var b3 = bala.instantiate()
	grupo = "Punto_origen3"
	b3.Type = tipo
	b3.global_position = get_tree().get_first_node_in_group(grupo).global_position
	b3.global_rotation = get_tree().get_first_node_in_group(grupo).global_rotation
	
	b1.apply_impulse(Vector2(bullet_spe,0).rotated(b1.global_rotation))
	b2.apply_impulse(Vector2(bullet_spe,0).rotated(b2.global_rotation))
	b3.apply_impulse(Vector2(bullet_spe,0).rotated(b3.global_rotation))
	
	get_parent().call_deferred("add_child",b1)
	get_parent().call_deferred("add_child",b2)
	get_parent().call_deferred("add_child",b3)


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	var animaciones_validas = [
		"Picas_y_Corazones", "Corazones", "Picas", "Diamantes", "trebol", "Cartas_Giratron",
		"Cajas_arriba", "Cajas_lado_ambos", "Cajas_lado_der", "Cajas_lado_iz"
	]
	if anim_name in animaciones_validas:
		var rng = randi_range(1,18)
		match rng:
			1: playback.travel("Picas_y_Corazones")
			2: playback.travel("Corazones")
			3: playback.travel("Picas")
			4: playback.travel("Diamantes")
			5: playback.travel("trebol")
			6: playback.travel("Cartas_Giratron")
			7: playback.travel("Cajas_arriba")
			8: playback.travel("Cajas_lado_ambos")
			9: playback.travel("Cajas_lado_der")
			10: playback.travel("Cajas_lado_iz")
			11: playback.travel("Cartas_Giratron")
			12: playback.travel("Cajas_arriba")
			13: playback.travel("Cajas_lado_ambos")
			14: playback.travel("Diamantes")
			15: playback.travel("Cajas_arriba")
			16: playback.travel("Cartas_Giratron")
			17: playback.travel("trebol")
			18: playback.travel("Cajas_lado_ambos")
			


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("bala_player"):
		vida -= area.get_parent().dano
		if vida < 0.01:
			playback.travel("muerte")
			emit_signal("ko")

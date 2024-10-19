extends Node2D

var playback : AnimationNodeStateMachinePlayback
var estado = "tierra"
var anim
var player
var fase1 = false
var bola = preload("res://esenas/bola_de_fuego.tscn")
var espina = preload("res://esenas/nicho_multipoe.tscn")
signal cambio_de_fase(value : int)
signal boss_muerto
var fase 
var muerto = false
@export var fase3 : bool 
@export var vida : int
@export var primera_fase : int
@export var segunda_fase : int
@export var boola : bool = false
@export var bullet_spe : float
@export var fase_ex : int
# Called when the node enters the scene tree for the first time.
func _ready():
	$"fase 1/fase 11".speed_scale = 0.1
	
	
	$"fase 1/MeshInstance2D/AnimatedSprite2D".play()
	$"fase 1/MeshInstance2D/AnimatedSprite2D2".play()
	$"fase 1/MeshInstance2D/AnimatedSprite2D3".play()
	$"fase 1/MeshInstance2D/AnimatedSprite2D4".play()
	$"fase 1/MeshInstance2D/AnimatedSprite2D5".play()
	$"fase 1/MeshInstance2D/AnimatedSprite2D6".play()
	
	$"fase 1/MeshInstance2D2/AnimatedSprite2D".play()
	$"fase 1/MeshInstance2D2/AnimatedSprite2D5".play()
	$"fase 1/MeshInstance2D2/AnimatedSprite2D3".play()
	$"fase 1/MeshInstance2D2/AnimatedSprite2D6".play()
	$"fase 1/MeshInstance2D2/AnimatedSprite2D2".play()
	$"fase 1/MeshInstance2D2/AnimatedSprite2D4".play()
	
	$"fase 1/sprites/MeshInstance2D/AnimatedSprite2D".play()
	$"fase 1/sprites/MeshInstance2D/AnimatedSprite2D2".play()
	$"fase 1/sprites/MeshInstance2D/AnimatedSprite2D3".play()
	$"fase 1/sprites/MeshInstance2D/AnimatedSprite2D4".play()
	$"fase 1/sprites/MeshInstance2D/AnimatedSprite2D5".play()
	$"fase 1/sprites/MeshInstance2D/AnimatedSprite2D6".play()
	
	$"fase 2/sprites/MeshInstance2D/AnimatedSprite2D".play()
	$"fase 2/sprites/MeshInstance2D/AnimatedSprite2D2".play()
	$"fase 2/sprites/MeshInstance2D/AnimatedSprite2D3".play()
	
	
	playback = $"fase 1/AnimationTree".get("parameters/playback")
	$"fase 1/AnimationTree".active = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	player = get_tree().get_nodes_in_group("player")[0].global_position
	$"fase 1/sprites/MeshInstance2D/position".look_at(player)
	
	dispari()

func estados() -> void:
	match playback.get_current_node():
		"normal debajo":
			estado = "tierra"
		"normal debajo 2":
			estado = "tierra"
		"normal derriva":
			estado = "cielo"
		"normal derriva 2":
			estado = "cielo"

func _on_animation_player_animation_finished(anim):
	$"fase 1/fase 1".start()
	

func escojer_movimiento():
	if !vida < primera_fase:
		estados()
		var radom = randi() % 3
		if estado == "tierra":
			if radom == 0:
				playback.travel("ataque debajo")
			elif radom == 1:
				playback.travel("bolas debajo")
			elif radom == 2:
				playback.travel("ir derriba")
		elif estado == "cielo":
			if radom == 0:
				playback.travel("ataque de riva")
			elif radom == 1:
				playback.travel("bolas derriba")
			elif radom == 2:
				playback.travel("ir debajo")
	elif vida < primera_fase and fase1 == false:
		if estado == "tierra":
			playback.travel("fin de fase")
		elif estado == "cielo":
			playback.travel("fin de fase2")
		fase = 1
		fase1 = true
		playback = $"fase 2/AnimationTree2".get("parameters/playback")
		emit_signal("cambio_de_fase", fase)
		


func _on_fase_1_timeout():
	escojer_movimiento()



func _on_animaciones_timeout():
	anim = playback.get_current_node()
	

func dispari():
	if boola == true:
		var b = bola.instantiate()
		var p = $"fase 1/sprites/MeshInstance2D/position"
		var pp = p.global_rotation
		b.global_position = p.global_position
		b.apply_impulse(Vector2(bullet_spe,0).rotated(pp))
		get_parent().call_deferred("add_child", b)
		boola = false

func _on_timer_timeout():
	pass


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("bala_player"):
		if fase == 2:
			vida -= area.get_parent().dano * 0.2
		else:
			vida -= area.get_parent().dano * 0.5
		if vida < 0.001 and muerto == false:
			emit_signal("boss_muerto")
			muerto = true
		if vida < segunda_fase and fase == 1:
			playback.travel("fin de fase")
			fase = 2
			
		


func disparar_espina():
	var b = espina.instantiate()
	var r = randi() % 3
	if r == 0:
		var p = $"fase 3/lanzar/Path2D/PathFollow2D"
		p.progress_ratio = randf_range(0, 1)
		b.global_position = p.global_position
		b._rotado = false
	elif r == 1:
		var p = $"fase 3/lanzar/Path2D2/PathFollow2D"
		p.progress_ratio = randf_range(0, 1)
		b.global_position = p.global_position
		b.rotado = true
		b._rotado = false
	elif r == 2:
		var p = $"fase 3/lanzar/Path2D3/PathFollow2D"
		p.progress_ratio = randf_range(0, 1)
		b.global_position = p.global_position
		b.rotado = false
		b._rotado = true
	
	get_parent().call_deferred("add_child", b)


func _on_espinas_timeout():
	if fase == 2 and fase3 == true:
		disparar_espina()


func _on_area_2d2_area_entered(area):
	if area.get_parent().is_in_group("bala_player"):
		vida -= area.get_parent().dano 
		if vida < 0.001 and muerto == false:
			emit_signal("boss_muerto")
			muerto = true
		if vida < segunda_fase and fase == 1:
			playback.travel("fin de fase")
			fase = 2

extends Node2D

var dic = {
	"Arma_basica" : 0.1,
	"Arma_laser" : 2,
	"Arma_laserx3" : 2,
	"Arma_basicax3" : 0.1
}
var bullet_spe = 4000
var nodo2
var nodo
var fin
var dano_p = 0
var bullet 
var disparo : String
var disparo_cambiado = false
var disparo_1 : String
var disparo_2 : String
@export var escal : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	disparo = Save.game_data.ARMA_EQUIPADA
	disparo_1 = Save.game_data.ARMA_EQUIPADA
	disparo_2 = Save.game_data.ARMA_EQUIPADA2
	if disparo == "Arma_basica":
		bullet = preload("res://esenas/bala.tscn")
	elif disparo == "Arma_basicax3":
		bullet = preload("res://esenas/bala_teledirigi.tscn")
	elif disparo == "Arma_laserx3":
		bullet = preload("res://esenas/plataformer/disparos/laser_x3.tscn")
	elif disparo == "Arma_laser":
		bullet = preload("res://esenas/laser.tscn")
		
	nodo = disparo+"/Marker2D"
	nodo2 = disparo+"/Marker2D2"
	
		

func _input(event):
	if event.is_action_pressed("cambio_de_arma"):
		if disparo_cambiado == false:
			disparo = disparo_2
			disparo_cambiado = true
		elif disparo_cambiado == true:
			disparo = disparo_1
			disparo_cambiado = false
		if disparo == "Arma_basica":
			bullet = preload("res://esenas/bala.tscn")
		elif disparo == "Arma_basicax3":
			bullet = preload("res://esenas/bala_teledirigi.tscn")
		elif disparo == "Arma_laserx3":
			bullet = preload("res://esenas/plataformer/disparos/laser_x3.tscn")
		elif disparo == "Arma_laser":
			bullet = preload("res://esenas/laser.tscn")
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fin = get_parent().fin


func _on_timer_timeout():
	if disparo == "Arma_basica":
		if get_parent().amuleto == "Amuleto_50_mas daño":
			dano_p = 0.5 * 0.7
		if Input.is_action_pressed("z") and fin == false:
			var b = bullet.instantiate()
			b.position = get_node(nodo).global_position
			b.dano = 0.5 + dano_p
			get_parent().get_parent().call_deferred("add_child", b)
			var a = bullet.instantiate()
			a.position = get_node(nodo2).global_position
			a.dano = 0.5 + dano_p
			get_parent().get_parent().call_deferred("add_child", a)
		dano_p = 0


func _on_laser_timeout():
	if disparo == "Arma_laser":
		if get_parent().amuleto == "Amuleto_50_mas daño":
			dano_p = 2 * 0.7
		
		if Input.is_action_pressed("z") and fin == false:
			var b = bullet.instantiate()
			b.position = get_node(nodo).global_position
			b.dano = 2 + dano_p
			get_parent().get_parent().call_deferred("add_child", b)
			var a = bullet.instantiate()
			a.position = get_node(nodo2).global_position
			a.dano = 2 + dano_p
			get_parent().get_parent().call_deferred("add_child", a)
			print(dano_p)
		dano_p = 0


func _on_telediri_timeout():
	if disparo == "Arma_basicax3":
		if get_parent().amuleto == "Amuleto_50_mas daño":
			dano_p = 0.5 * 0.7
		if Input.is_action_pressed("z") and fin == false:
			var b = bullet.instantiate()
			b.position = get_node(nodo).global_position
			b.dano = 0.5 + dano_p
			get_parent().get_parent().call_deferred("add_child", b)
			var a = bullet.instantiate()
			a.position = get_node(nodo2).global_position
			a.dano = 0.5 + dano_p
			get_parent().get_parent().call_deferred("add_child", a)
		dano_p = 0


func _on_laserx3_timeout():
	if disparo == "Arma_laserx3":
		if get_parent().amuleto == "Amuleto_50_mas daño":
			dano_p = 0.3 * 0.7
		
		if Input.is_action_pressed("z") and fin == false:
			var b = bullet.instantiate()
			b.position = get_node(nodo).global_position
			b.dano = 0.3 + dano_p
			b.scalee = escal
			b.global_rotation = $MeshInstance2D.rotation
			b.apply_impulse(Vector2(bullet_spe,0).rotated($MeshInstance2D.rotation))
			get_parent().get_parent().call_deferred("add_child", b)
			var a = bullet.instantiate()
			a.position = get_node(nodo2).global_position
			a.dano = 0.3 + dano_p
			a.scalee = escal
			a.global_rotation = $MeshInstance2D.rotation
			a.apply_impulse(Vector2(bullet_spe,0).rotated($MeshInstance2D.rotation))
			get_parent().get_parent().call_deferred("add_child", a)
			print(dano_p)
			var b2 = bullet.instantiate()
			b2.position = get_node(nodo).global_position
			b2.dano = 0.3 + dano_p
			b2.scalee = escal
			b2.global_rotation = $MeshInstance2D2.rotation
			b2.apply_impulse(Vector2(bullet_spe,0).rotated($MeshInstance2D2.rotation))
			get_parent().get_parent().call_deferred("add_child", b2)
			var a2 = bullet.instantiate()
			a2.position = get_node(nodo2).global_position
			a2.dano = 0.3 + dano_p
			a2.scalee = escal
			a2.global_rotation = $MeshInstance2D2.rotation
			a2.apply_impulse(Vector2(bullet_spe,0).rotated($MeshInstance2D2.rotation))
			get_parent().get_parent().call_deferred("add_child", a2)
			print(dano_p)
		dano_p = 0

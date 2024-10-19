extends Node2D

@export var bullet_spe : float
@export var bullet_spe_bomba : float
var bullet_normal = preload("res://esenas/plataformer/disparos/bala_normal.tscn")
var bullet_laser = preload("res://esenas/plataformer/disparos/laser_o.tscn")
var bullet_laser_x3 = preload("res://esenas/plataformer/disparos/laser_x3.tscn")
var bullet_teledirigida = preload("res://esenas/bala_teledirigi.tscn")
var bullet_bomba = preload("res://esenas/plataformer/disparos/bomba.tscn")
var bullet_carga = preload("res://esenas/plataformer/disparos/bala_cargada.tscn")
var arma 
var arma_1
var arma_2
var arma_cambiada = false
var danoo : float

var cooldown = false
var carga_de_carga = 0

var daños = {
	"basico" : 0.9,
	"teledirigido" : 0.7,
	"laser" : 6,
	"mayor_daño" : 0.4,
	"bomba" : 4,
	"cargado" : 2
	}


# Called when the node enters the scene tree for the first time.
func _ready():
	arma = Save.game_data.ARMA_EQUIPADA
	arma_1 = Save.game_data.ARMA_EQUIPADA
	arma_2 = Save.game_data.ARMA_EQUIPADA2
	if get_parent().amuleto == "Amuleto_50_mas daño":
		if arma == "Arma_basica":
			$bum.modulate = Color(1, 1, 0)
			danoo = daños.basico *2
		elif arma == "Arma_laser":
			$bum.modulate = Color(1, 0, 0)
			danoo = daños.laser *2
		elif arma == "Arma_basicax3":
			$bum.modulate = Color(1, 0, 1)
			danoo = daños.teledirigido *2
		elif arma == "Arma_laserx3":
			$bum.modulate = Color(1, 1, 0)
			danoo = daños.mayor_daño *2
		elif arma == "bomba":
				$bum.modulate = Color(1, 1, 0)
				danoo = daños.bomba*2
		elif arma == "carga":
				$bum.modulate = Color(1, 1, 0)
				danoo = daños.cargado *2
	else:
		if arma == "Arma_basica":
			$bum.modulate = Color(1, 1, 0)
			danoo = daños.basico #9 de daño por segundo
		elif arma == "Arma_laser":
			$bum.modulate = Color(1, 0, 0)
			danoo = daños.laser #10 de daño por segundo
		elif arma == "Arma_basicax3":
			$bum.modulate = Color(1, 0, 1)
			danoo = daños.teledirigido#12 de daño por segundo
		elif arma == "Arma_laserx3":
			$bum.modulate = Color(1, 1, 0)
			danoo = daños.mayor_daño#12 de daño por segundo
		elif arma == "bomba":
			$bum.modulate = Color(1, 1, 0)
			danoo = daños.bomba#10 de daño por segundo
		elif arma == "carga":
			$bum.modulate = Color(1, 1, 0)
			danoo = daños.cargado#10 de daño por segundo



func _input(event):
	
	
	if event.is_action_pressed("cambio_de_arma"):
		if arma_cambiada == false:
			arma = arma_2
			arma_cambiada = true
		elif arma_cambiada == true:
			arma = arma_1
			arma_cambiada = false
	if get_parent().amuleto == "Amuleto_50_mas daño":
		if arma == "Arma_basica":
			$bum.modulate = Color(1, 1, 0)
			danoo = daños.basico + (daños.basico* 0.7)
		elif arma == "Arma_laser":
			$bum.modulate = Color(1, 0, 0)
			danoo = daños.laser + (daños.laser* 0.7)
		elif arma == "Arma_basicax3":
			$bum.modulate = Color(1, 0, 1)
			danoo = daños.teledirigido + (daños.teledirigido* 0.7)
		elif arma == "Arma_laserx3":
			$bum.modulate = Color(1, 1, 0)
			danoo = daños.mayor_daño + (daños.mayor_daño* 0.7)
		elif arma == "bomba":
				$bum.modulate = Color(1, 1, 0)
				danoo = daños.bomba + (daños.bomba* 0.7)
	else:
		if arma == "Arma_basica":
			$bum.modulate = Color(1, 1, 0)
			danoo = daños.basico #9 de daño por segundo
		elif arma == "Arma_laser":
			$bum.modulate = Color(1, 0, 0)
			danoo = daños.laser #10 de daño por segundo
		elif arma == "Arma_basicax3":
			$bum.modulate = Color(1, 0, 1)
			danoo = daños.teledirigido#12 de daño por segundo
		elif arma == "Arma_laserx3":
			$bum.modulate = Color(1, 1, 0)
			danoo = daños.mayor_daño#12 de daño por segundo
		elif arma == "bomba":
			$bum.modulate = Color(1, 1, 0)
			danoo = daños.bomba#10 de daño por segundo

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if arma == "carga" and get_parent().fin == false:
		if Input.is_action_just_pressed("z"):
			carga_de_carga += 1
			$carga/AnimationPlayer.play(str(carga_de_carga))
			$cargar.start()
			cooldown = true
		elif Input.is_action_just_released("z") and cooldown == true:
			var b = bullet_carga.instantiate()
			b.global_rotation_degrees = global_rotation_degrees
			b.global_position = $arker2D.global_position
			b.carga = carga_de_carga
			b.dano = danoo
			b.apply_impulse(Vector2(bullet_spe, 0).rotated(rotation))
			get_tree().get_first_node_in_group("nivel").get_parent().call_deferred("add_child",b)
			$AnimatedSprite2D.play("tiro")
			$bum.play("default")
			carga_de_carga = 0
			$cargar.stop()
			cooldown = false
			$carga/AnimationPlayer.play(str(carga_de_carga))
	
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down"):
		var total_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		var rrotation = rad_to_deg(total_direction.angle())
		rotation_degrees = rrotation


func _on_normal_timeout():
	if arma == "Arma_basica" and get_parent().fin == false:
		if Input.is_action_pressed("z"):
			var b = bullet_normal.instantiate()
			b.global_rotation_degrees = global_rotation_degrees
			b.global_position = $arker2D.global_position
			b.dano = danoo
			b.apply_impulse(Vector2(bullet_spe,0).rotated(rotation))
			get_parent().get_parent().call_deferred("add_child",b)
			$AnimatedSprite2D.play("tiro")
			$bum.play("default")


func _on_laser_timeout():
	if arma == "Arma_laser" and get_parent().fin == false:
		if Input.is_action_pressed("z"):
			var b = bullet_laser.instantiate()
			b.global_rotation_degrees = global_rotation_degrees
			b.global_position = $arker2D.global_position
			b.dano = danoo
			b.apply_impulse(Vector2(bullet_spe,0).rotated(rotation))
			get_parent().get_parent().call_deferred("add_child",b)
			$AnimatedSprite2D.play("tiro")
			$bum.play("default")


func _on_telediri_timeout():
	if arma == "Arma_basicax3" and get_parent().fin == false:
		if Input.is_action_pressed("z"):
			var b = bullet_teledirigida.instantiate()
			b.global_rotation_degrees = global_rotation_degrees
			b.global_position = $arker2D.global_position
			b.horizonte = true
			b.dano = danoo
			b.apply_impulse(Vector2(bullet_spe,0).rotated(rotation))
			get_parent().get_parent().call_deferred("add_child",b)
			$AnimatedSprite2D.play("tiro")
			$bum.play("default")


func _on_laserx_3_timeout():
	if arma == "Arma_laserx3" and get_parent().fin == false:
		if Input.is_action_pressed("z"):
			var b = bullet_laser_x3.instantiate()
			b.global_rotation_degrees = $MeshInstance2D.global_rotation_degrees
			b.global_position = $MeshInstance2D.global_position
			b.dano = danoo
			b.apply_impulse(Vector2(bullet_spe,0).rotated($MeshInstance2D.global_rotation))
			get_parent().get_parent().call_deferred("add_child",b)
			var b2 = bullet_laser_x3.instantiate()
			b2.global_rotation_degrees = $MeshInstance2D2.global_rotation_degrees
			b2.global_position = $MeshInstance2D2.global_position
			b2.dano = danoo
			b2.apply_impulse(Vector2(bullet_spe,0).rotated($MeshInstance2D2.global_rotation))
			get_parent().get_parent().call_deferred("add_child",b2)
			var b3 = bullet_laser_x3.instantiate()
			b3.global_rotation_degrees = $MeshInstance2D3.global_rotation_degrees
			b3.global_position = $MeshInstance2D3.global_position
			b3.dano = danoo
			b3.apply_impulse(Vector2(bullet_spe,0).rotated($MeshInstance2D3.global_rotation))
			get_parent().get_parent().call_deferred("add_child",b3)
			$AnimatedSprite2D.play("tiro")
			$bum.play("default")


func _on_bomba_timeout():
	if arma == "bomba" and get_parent().fin == false:
		if Input.is_action_pressed("z"):
			var b = bullet_bomba.instantiate()
			b.global_rotation_degrees = global_rotation_degrees
			b.global_position = $arker2D.global_position
			b.dano = danoo
			b.apply_impulse(Vector2(bullet_spe, 0).rotated(rotation))
			get_tree().get_first_node_in_group("nivel").get_parent().call_deferred("add_child",b)
			$AnimatedSprite2D.play("tiro")
			$bum.play("default")


func _on_cargar_timeout():
	
	if carga_de_carga < 4:
		carga_de_carga += 1
		$carga/AnimationPlayer.play(str(carga_de_carga))
		
		$GPUParticles2D5.emitting = true


func _on_cooldown_timeout():
	pass

extends CharacterBody2D

signal Game_Over
var muerto = false
var fin = false
var r 
var salto_disponible = true
var escala = 4.27
@export var SPEED = 64000.0
@export var JUMP_VELOCITY = -1800.0
var agachado = false
var en_aire = false
var plat = false
var lado = "ui_right"
var vel_dash = 2810
var dash = false
var num_dash = 0
var amuleto
@export var curacion = false
@export var sonido : AudioStream
@export var inmunidad = false
var vida : float = 3
var max_vida : float
var vel_lanzado = 3500
var Zoom_de_camara
var posisioc_de_la_camara
var minus_barra : float
var porcentaje : float
@export_category("Debug")
@export var Filtro = true




# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if Filtro == false:
		$CanvasLayer3/MeshInstance2D.hide()
	
	
	
	
	posisioc_de_la_camara = $Camera2D.global_position
	Zoom_de_camara = $Camera2D.zoom
	$AudioStreamPlayer.stream = sonido
	$AudioStreamPlayer.play()
	amuleto = Save.game_data.AMULETO_EQUIPADO
	if amuleto == "Amuleto_5_vidas":
		vida = 5
		$CanvasLayer/Label.text = str(vida)
	elif amuleto == "Amuleto_escudo_orbital":
		$escudo_orbital/StaticBody2D/CollisionShape2D5.disabled = false
		$escudo_orbital/StaticBody2D/CollisionShape2D6.disabled = false
		$escudo_orbital/StaticBody2D/CollisionShape2D7.disabled = false
		$escudo_orbital/StaticBody2D/CollisionShape2D8.disabled = false
		$escudo_orbital.show()
	max_vida = vida
	
	#barra de vida
	minus_barra = 1.00/max_vida
	$CanvasLayer/MeshInstance2D.material.set_shader_parameter("value",vida*minus_barra)
	$CanvasLayer/MeshInstance2D.material.set_shader_parameter("segment_count",max_vida)
	

func _input(event):
	if event.is_action_pressed("saltar") and Input.is_action_pressed("ui_down") and is_on_floor() and curacion == false:
		position.y += 0.01 * gravity
		$AnimationPlayer.play("salto")
		
	var tween2 : Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	var tween : Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	var posT2 : Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	var posT : Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	if event.is_action_pressed("cure"):
		if amuleto == "Amuleto_Curacion_hollow_knight":
			$currar.play("cura")
			$Node2D/AnimatedSprite2D/AnimatedSprite2D.play()
			tween.tween_property($Camera2D, "zoom", Vector2(0.5, 0.5), 1)
			posT.tween_property($Camera2D, "global_position", global_position , 1)
	if event.is_action_released("cure"):
		if amuleto == "Amuleto_Curacion_hollow_knight":
			$currar.play("RESET")
			tween2.tween_property($Camera2D, "zoom", Zoom_de_camara, 1)
			posT2.tween_property($Camera2D, "global_position", posisioc_de_la_camara , 1)
	
	
	if event.is_action_pressed("humo"):
		if dash == false and num_dash == 0:
			$dash2.play("RESET")
			$AnimatedSprite2D3.play("default")
			if lado == "ui_right":
				velocity.x = vel_dash
				$GPUParticles2D2.emitting = true
			elif lado == "ui_left":
				velocity.x = -vel_dash
				$GPUParticles2D3.emitting = true
			if amuleto == "Amuleto_maniobra_evasiva":
				$dash2.play("humo")
				$dash3.start()
			else:
				$dash2.play("dash")
			$alas.play("dash")
			num_dash += 1
			dash = true
			$dash.start()
			

func _physics_process(delta):
	
	if amuleto == "Amuleto_escudo_orbital":
		$escudo_orbital/StaticBody2D.rotation += 2.5 * get_physics_process_delta_time()
	if Input.is_action_pressed("ui_down") and en_aire == false  and curacion == false:
		agachado = true
	else:
		if agachado == true  and curacion == false:
			$AnimationPlayer.play("des_agachaer")
			agachado = false
	if Input.is_action_pressed("ui_left")  and curacion == false:
		lado = "ui_left"
		$AnimatedSprite2D2.scale.x = -escala
		$AnimatedSprite2D3.scale.x = -escala
		$alas.scale.x = -4.188
	
	elif Input.is_action_pressed("ui_right")  and curacion == false:
		$AnimatedSprite2D2.scale.x = escala
		$AnimatedSprite2D3.scale.x = escala
		$alas.scale.x = 4.188
		lado = "ui_right"
		
		
		
	if is_on_floor()  and curacion == false:
		salto_disponible = true
	
	# Add the gravity.
	r = $RayCast2D.get_collider()
	if not is_on_floor():
		if dash == false:
			velocity.y += 1.5 * (gravity * delta)
			if r == null:
				if !dash == true:
					$AnimationPlayer.play("salto")
	if  is_on_floor() or !r == null:
		if agachado == false:
			pass
		en_aire = false
		if !amuleto == "Amuleto_maniobra_evasiva":
			num_dash = 0
		# Handle Jump.
		if !r == null:
			if r.is_in_group("no_saltable") and Input.is_action_pressed("ui_down"):
				plat = true
			else:
				plat = false
		if !r == null:
			if Input.is_action_just_pressed("saltar") and plat == false and salto_disponible == true  and curacion == false:
				velocity.y = JUMP_VELOCITY
				$AnimationPlayer.play("salto")
				agachado = false
				en_aire = true
				salto_disponible = false
				$salto.start()
 
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if dash == false and !Input.is_action_pressed("apuntar"):
		if direction and agachado == false:
			velocity.x = direction * (SPEED * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED * delta)
	if Input.is_action_just_pressed("apuntar"):
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
	move_and_slide()
	
	
	
	
	
	if is_on_floor():
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
			if !Input.is_action_pressed("apuntar"):
				$AnimatedSprite2D2.play("correr")
		elif  Input.is_action_pressed("apuntar"):
			$AnimatedSprite2D2.play("default")
		elif Input.is_action_pressed("ui_down"):
			$AnimationPlayer.play("agachar")
		else:
			$AnimatedSprite2D2.play("default")
	else:
		$AnimatedSprite2D2.play("caer")
	if muerto == true:
		$Area2D/CollisionShape2D.disabled = true




func apuntado():
	pass


func _on_dash_timeout():
	dash = false
	velocity.x = 0
	$GPUParticles2D2.emitting = false
	$GPUParticles2D3.emitting = false
	


func _on_dash_3_timeout():
	num_dash = 0


func _on_area_2d_area_entered(area):
	if area.is_in_group("bala_enemy") or area.get_parent().is_in_group("bala_enemy"):
		if inmunidad == false and fin == false:
			vida -= 1
			$muerte.play("muerte2")
			$Camera2D.a_plichake()
	
	
	if area.is_in_group("Suelo_ene"):
		velocity.y = -vel_lanzado
		if inmunidad == false and fin == false:
			vida -= 1
			$muerte.play("muerte2")
			$Camera2D.a_plichake()
	$CanvasLayer/Label.text = str(vida)
	$CanvasLayer/MeshInstance2D.material.set_shader_parameter("value",vida*minus_barra)
	
	if vida < 3:
		$CanvasLayer/caos.play("new_animation2")
	if vida < 2:
		$CanvasLayer/caos.play("new_animation")
	if vida < 1:
		game_over()


func game_over():

	emit_signal("Game_Over")
	muerto = true
	fin = true
	$AnimatedSprite2D2.hide()
	$rooter.hide()
	$alas.hide()
	$die.play("new_animation")
	$Camera2D.randistri = 0
	$Camera2D.sakefase = 0
	
	
	

func _on_boss_ko():
	fin = true
	$AudioStreamPlayer.stop()

func _on_salto_timeout():
	salto_disponible = true


func _on_currar_animation_finished(anim_name):
	var tween : Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	var tween2 : Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	if anim_name == "cura" and muerto == false:
		vida += 1
		if vida > max_vida:
			vida = max_vida
		tween.tween_property($Camera2D, "zoom", Zoom_de_camara, 1)
		tween2.tween_property($Camera2D, "global_position", posisioc_de_la_camara, 1)
		$CanvasLayer/Label.text = str(vida)
		$CanvasLayer/MeshInstance2D.material.set_shader_parameter("value",vida*minus_barra)
		$Node2D/AnimatedSprite2D.play()



	

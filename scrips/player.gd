extends CharacterBody2D

var amuleto : String
var lado = false 
var esc = false
@export var colisiona = false
@export var dano_p : float
@export var cadencia_de_disparo : float
var bullet = preload("res://esenas/bala.tscn")
const SPEED = 1600.0
var fin = false
const JUMP_VELOCITY = -400.0
@export var vidas : int = 3
@export var song : AudioStream
@export var screen_sizex : float
@export var screen_sizey : float
var posis 

# Get the gravity from the project settings to be synced with RigidBody nodes.

func _emiting():
	$AnimatedSprite2D/GPUParticles2D.emitting = true
	$AnimatedSprite2D/GPUParticles2D2.emitting = true


func _ready():
	$DIE_MORE/AudioStreamPlayer.stream = song
	$DIE_MORE/AudioStreamPlayer.play()
	
	amuleto = Save.game_data.AMULETO_EQUIPADO 
	if !amuleto == "Amuleto_escudo_orbital":
		$"escudo orbital/esc/CollisionShape2D".disabled = true
		$"escudo orbital".hide()
	
	
	if amuleto == "Amuleto_5_vidas":
		vidas = 5
	else:
		vidas = 3
	_emiting()
	
	$CanvasLayer/Label.text = str(vidas)

func _input(event):
	if event.is_action_pressed("humo") and amuleto == "Amuleto_maniobra_evasiva":
		$"bomba de humo/MeshInstance2D/AnimationPlayer".play("new_animation")
	
	
	if event.is_action_pressed("ui_left"):
		$AnimatedSprite2D.play("lado")
		$AnimatedSprite2D.scale.x = 0.512
		lado = true
		$lados.play("izqui")
	elif event.is_action_pressed("ui_right"):
		$AnimatedSprite2D.play("lado")
		$AnimatedSprite2D.scale.x = -0.512
		lado = true
		$lados.play("izqui")

func _physics_process(delta):
	if Input.is_action_pressed("humo"):
		esc = true
	else :
		esc = false
	if esc == false:
		$"escudo orbital/esc".rotation += 0.1
	
	
	
	if fin == true:
		$AnimatedSprite2D/Area2D/CollisionShape2D.disabled = true
	# Obtén la posición actual del jugador
	var player_position = position

	# Establece los límites de la pantalla
	var screen_left = -3000.0
	var screen_top = -3000.0
	var screen_right = screen_sizex
	var screen_bottom = screen_sizey

	# Restringe la posición del jugador dentro de los límites de la pantalla
	player_position.x = clamp(player_position.x, screen_left, screen_right)
	player_position.y = clamp(player_position.y, screen_top, screen_bottom)

	# Establece la nueva posición del jugador
	position = player_position

	
	
	
	if lado == true and !Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.play("default")
		lado = false
		$lados.play("new_animation")
	
	
	if Input.is_action_pressed("z"):
		$AnimatedSprite2D/shoot.play("default")
	else :
		$AnimatedSprite2D/shoot.play("default2")
	$Marker2D.position.y = -85 + position.y
	$Marker2D.position.x = -75 + position.x
	$Marker2D2.position.y = -85 + position.y
	$Marker2D2.position.x = 75 + position.x
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	var directiony = Input.get_axis("ui_up", "ui_down")
	if directiony:
		velocity.y = directiony * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()



	

func game_over():
	fin = true
	hide()
	$Die._game_over()
	$DIE_MORE/AnimationPlayer.play("new_animation")

func _bala_recibida():
	if colisiona == false:
		colisiona = true
		$Camera2D.a_plichake()
		$"ñoñsos".play("new_animation")
		vidas -= 1
		$CanvasLayer/Label.text = str(vidas)
		if vidas < 3:
			$CanvasLayer/caos.play("new_animation2")
		if vidas < 2:
			$CanvasLayer/caos.play("new_animation")
		if vidas < 1:
			game_over()
			


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("bala_enemy"):
		_bala_recibida()





func _on_boss_ko():
	fin = true

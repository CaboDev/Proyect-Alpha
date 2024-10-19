extends RigidBody2D

var scalee
@export var laser = false
@export var bomba = false
@export var carga = 0 
var dano : float
# Called when the node enters the scene tree for the first time.
func _ready():
	if carga == 1:
		$GPUParticles2D2.scale = Vector2(1,1)
		$GPUParticles2D5.scale = Vector2(0.5,0.5)
		$GPUParticles2D5.amount = 40
		$GPUParticles2D2.amount = 30
		if Save.game_data.AMULETO_EQUIPADO == "Amuleto_50_mas daño":
			dano = 4
	elif carga == 2:
		$GPUParticles2D2.scale = Vector2(6.385,6.385)
		$GPUParticles2D2.amount = 40
		dano = 20
		if Save.game_data.AMULETO_EQUIPADO == "Amuleto_50_mas daño":
			dano = 40
	elif carga == 3:
		$GPUParticles2D2.scale = Vector2(22.06,22.06)
		$GPUParticles2D2.amount = 75
		dano = 40
		if Save.game_data.AMULETO_EQUIPADO == "Amuleto_50_mas daño":
			dano = 80
	elif carga > 3:
		$GPUParticles2D2.scale = Vector2(35.06,35.06)
		$GPUParticles2D2.amount = 120
		dano = 80
		if Save.game_data.AMULETO_EQUIPADO == "Amuleto_50_mas daño":
			dano = 160
	
	print("carga")
	
	if !scalee == null:
		$Area2D.scale = scalee
		$VisibleOnScreenNotifier2D.scale = scalee
		$MeshInstance2D.scale = $MeshInstance2D.scale * scalee 
		$MeshInstance2D2.scale = $MeshInstance2D2.scale * scalee


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	if area.is_in_group("enemy") or area.get_parent().is_in_group("enemy"):
		if bomba == true:
			romper_bomb()
		else:
			linear_velocity = Vector2(0, 0)
			$AnimatedSprite2D.play("salir")
			if carga > 0:
				$GPUParticles2D2.emitting = false
				$GPUParticles2D5.emitting = true


func _on_area_2d_body_entered(body):
	if body.is_in_group("no_pasable"):
		if bomba == true:
			romper_bomb()
		else:
			linear_velocity = Vector2(0, 0)
			$AnimatedSprite2D.play("salir")
		if carga > 0:
				$GPUParticles2D2.emitting = false
				$GPUParticles2D5.emitting = true
		

func romper_bomb():
	linear_velocity = Vector2(0,0)
	gravity_scale = 0
	$AnimationPlayer.play("new_animation_2")

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_timer_timeout():
	linear_velocity = Vector2(0, 0)
	$AnimatedSprite2D.play("salir")
	


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "new_animation_2":
		queue_free()


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "salir":
		queue_free()

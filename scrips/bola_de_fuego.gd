extends RigidBody2D
var Color_del_luz : Color
@export var bola = "fuego"

# Called when the node enters the scene tree for the first time.
func _ready():
	if bola == "energía_gravedad":
		gravity_scale = 0.6
		$PointLight2D.color = Color(0, 1, 1)
		$AnimatedSprite2D.play("energia")
		$Area2D.scale = Vector2(0.8,0.8)
		$AnimatedSprite2D.scale = Vector2(5,5)
	elif bola == "fuego":
		gravity_scale = 0
		$PointLight2D.color = Color(1, 0.5, 0)
		$AnimatedSprite2D.play("default")
		$Area2D.scale = Vector2(1,1)
	elif bola == "digital":
		$AnimatedSprite2D/GPUParticles2D2.emitting = true
		$PointLight2D.color = Color.GREEN
		$AnimatedSprite2D.play("digital")
		$Area2D.scale = Vector2(0.8,0.8)
	elif bola == "fuego_morao":
		gravity_scale = 0
		$AnimatedSprite2D.scale = Vector2(4.5,4.5)
		$PointLight2D.color = Color(1, 0, 1)
		$AnimatedSprite2D.play("morao")
		$Area2D.scale = Vector2(1,1)
	elif bola == "araña_rosa":
		gravity_scale = -0.4
		$AnimatedSprite2D.scale = Vector2(4.5,4.5)
		$PointLight2D.color = Color_del_luz
		$PointLight2D.scale = Vector2(3.14, 3.14)
		$AnimatedSprite2D.play("aracno")
		$Area2D.scale = Vector2(3,3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	if bola == "araña_rosa":
		$Timer2.start()
	else:
		$Timer.start()


func _on_area_2d_body_entered(body):
	if body.is_in_group("escudo"):
		if bola == "digital":
			$AnimatedSprite2D/GPUParticles2D2.emitting = false
			$AnimatedSprite2D/GPUParticles2D3.emitting = true
			linear_velocity = Vector2(0,0)
			$Area2D/CollisionShape2D2.queue_free()
			
		$AnimatedSprite2D.play(bola)
		$Timer.start()
		$Area2D/CollisionShape2D2.queue_free()
		linear_velocity = Vector2(0,0)
		




func _on_timer_timeout():
	queue_free()


func _on_area_2d_area_entered(area):
	if area.is_in_group("player"):
		if bola == "digital":
			$Area2D/CollisionShape2D2.queue_free()
			$AnimatedSprite2D/GPUParticles2D2.emitting = false
			$AnimatedSprite2D/GPUParticles2D3.emitting = true
			linear_velocity = Vector2(0,0)
			$Timer.start()
	if area.get_parent().is_in_group("bala_player"):
		if bola == "did":
			$Area2D/CollisionShape2D2.queue_free()
			$AnimatedSprite2D/GPUParticles2D2.emitting = false
			$AnimatedSprite2D/GPUParticles2D3.emitting = true
			linear_velocity = Vector2(0,0)
			$Timer.start()

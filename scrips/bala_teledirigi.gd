extends RigidBody2D

var dano : float
var enemy = null
var horizonte = false
var move = Vector2.ZERO
const SPEED = 70.0



func _ready():
	if horizonte == true:
		$Node2D.rotation = -80
		$Node2D.position.x = -32
		$Node2D.position.y = 0
		$Node2D.scale = Vector2(0.3, 0.3)
		$Area2D.scale = Vector2(0.3, 0.3)


func _physics_process(delta):
	
	move = Vector2.ZERO
	if enemy != null:
	
		$Node2D.rotation = 90
		look_at(enemy.global_position)
		move = position.direction_to(enemy.global_position)
		
	else:
		if horizonte == false:
			move.y -= SPEED
			$Node2D.rotation = 0
	
	
	move = move.normalized() * SPEED
	move = move_and_collide(move)
	


func _on_area_2d_2_area_entered(area):
	if area.is_in_group("enemyb"):
		enemy = area.get_parent()
		
	elif area.is_in_group("enemy"):
		enemy = area


func _on_area_2d_2_area_exited(area):
	if area.is_in_group("enemy"):
		enemy = null


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("enemy"):
		$Node2D/AnimatedSprite2D.play("salir")
	if area.is_in_group("enemy"):
		$Node2D/AnimatedSprite2D.play("salir")


func _on_area_2d_body_entered(body):
	if body.is_in_group("no_pasable"):
		$Node2D/AnimatedSprite2D.play("salir")


func _on_animated_sprite_2d_animation_finished():
	if $Node2D/AnimatedSprite2D.animation == "salir":
		queue_free()

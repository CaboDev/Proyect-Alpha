extends RigidBody2D

@export var dano: float
@export var TURN_SPEED: float = 3.5  
@export var SPEED: float = 1900.0

var enemy: Node2D = null
var horizonte: bool = false

func _ready():
	if horizonte:
		$Node2D.position = Vector2(-32, 0)
		$Node2D.scale = Vector2(0.3, 0.3)
		$Area2D.scale = Vector2(0.3, 0.3)

func _physics_process(delta):
	if enemy:
		var dir = (enemy.global_position - global_position).normalized()
		rotation = lerp_angle(rotation, dir.angle(), TURN_SPEED * delta)
		linear_velocity = Vector2.RIGHT.rotated(rotation) * SPEED
	else:
		if not horizonte:
			linear_velocity = Vector2(0, -SPEED)  # Movimiento recto hacia arriba

func _on_area_2d_2_area_entered(area):
	if area.is_in_group("enemyb") or area.is_in_group("enemy"):
		enemy = area.get_parent()



func _on_area_2d_2_area_exited(area):
	if area.is_in_group("enemy"):
		enemy = null


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("enemy"):
		$Node2D/AnimatedSprite2D.play("salir")
		enemy = null
		$Area2D.queue_free()
		$Area2D2.queue_free()
		linear_velocity = Vector2(0,0)
	if area.is_in_group("enemy"):
		$Node2D/AnimatedSprite2D.play("salir")
		enemy = null
		$Area2D.queue_free()
		$Area2D2.queue_free()
		linear_velocity = Vector2(0,0)


func _on_area_2d_body_entered(body):
	if body.is_in_group("no_pasable"):
		$Node2D/AnimatedSprite2D.play("salir")


func _on_animated_sprite_2d_animation_finished():
	if $Node2D/AnimatedSprite2D.animation == "salir":
		queue_free()

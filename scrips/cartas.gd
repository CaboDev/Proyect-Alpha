extends RigidBody2D
var Type = "pica"
func _ready():
	$AnimatedSprite2D.play(Type)
func destruir():
	$GPUParticles2D.emitting = true
	$AnimatedSprite2D.hide()
	$Area2D.queue_free()
	linear_velocity = Vector2(0,0)
func _on_area_2d_body_entered(body):
	if body.is_in_group("escudo"):
		destruir()
func _on_area_2d_area_entered(area):
	if area.is_in_group("player"):
		destruir()
func _on_timer_timeout() -> void:
	queue_free()

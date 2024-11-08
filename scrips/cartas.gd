extends RigidBody2D
var Type = "pica"

func _ready():
	$AnimatedSprite2D.play(Type)



func _on_area_2d_body_entered(body):
	if body.is_in_group("escudo"):
		queue_free()


func _on_area_2d_area_entered(area):
	if area.is_in_group("player"):
		queue_free()

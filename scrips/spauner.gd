extends Node2D

@export var en_nivel : bool
@export var vedorw : Vector2
@export var vedor : Vector2
var bulletoo = preload("res://esenas/bulleto.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if en_nivel == false:
		if get_parent().muerto == false :
			var rani = randi() % 2
			var b = bulletoo.instantiate()
			if rani == 0:
				b.position = vedor
			elif rani == 1:
				b.position = vedorw
			get_parent().get_parent().call_deferred("add_child", b)
	else:
		var rani = randi() % 2
		var b = bulletoo.instantiate()
		if rani == 0:
			b.position = vedor
		elif rani == 1:
			b.position = vedorw
			get_parent().get_parent().call_deferred("add_child", b)


func _on_laser_timeout():
	if get_parent().muerto == false:
		var randio = randi() % 3
		if randio == 0:
			$Node2D/Area2D/AnimationPlayer.play("new_animation")
			$AnimatedSprite2D2.play("default")
			$AnimatedSprite2D2.flip_h = true
			$AnimatedSprite2D2.position.x = 528
			$MeshInstance2D.position.x =569
		elif randio == 1:
			$Node2D2/Area2D/AnimationPlayer.play("new_animation")
			$AnimatedSprite2D2.play("default")
			$AnimatedSprite2D2.flip_h = false
			$AnimatedSprite2D2.position.x = -117.334
			$MeshInstance2D.position.x =-231.334


func _on_laaser_vertical_timeout():
	if get_parent().muerto == false:
		$Node2D3/Area2D/AnimationPlayer.play("new_animation_2")

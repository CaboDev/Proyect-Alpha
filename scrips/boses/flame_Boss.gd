extends Node2D

@export var vida = 300
@export var activo = false
@export var b = false

var en_fin =false

signal ko 

var ba = preload("res://esenas/plataformer/loadi.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if b == true:
		$AnimationPlayer.play("new_animation")
		$CanvasLayer.show()
		b = false


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("bala_player"):
		vida -= area.get_parent().dano
		$AudioStreamPlayer2D.play()
		if vida < 0.1 && en_fin == false:
			activo = false
			$AnimatedSprite2D13.play("new_animation")
			$AnimationPlayer.queue_free()
			emit_signal("ko")
			en_fin = true


func _on_timer_timeout():
	if activo == true:
		var b = ba.instantiate()
		b.global_position = global_position
		print("sda")
		get_parent().call_deferred("add_child",b)



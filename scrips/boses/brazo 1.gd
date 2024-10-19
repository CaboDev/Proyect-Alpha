extends Node2D

@export var vida : int = 300
var muerto = false
@export var activo = false
@export var ataque : String
@export var Probabilidad : Vector2
@export var disparo : bool
var bola = preload("res://esenas/bola_de_fuego.tscn")
signal brazo_caido

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if disparo == true and activo == true:
		var b = bola.instantiate()
		var p = $Skeleton2D/Bone2D2/Bone2D/Bone2D2/Bone2D3/Bone2D4/Bone2D5/Bone2D6/Node2D/MeshInstance2D
		var pp = p.global_rotation
		b.global_position = p.global_position
		b.apply_impulse(Vector2(1000,0).rotated(pp))
		b.bola = "energía_gravedad"
		get_parent().call_deferred("add_child", b)
		
		
		var b2 = bola.instantiate()
		var p2 = $Skeleton2D/Bone2D2/Bone2D/Bone2D2/Bone2D3/Bone2D4/Bone2D5/Bone2D6/Node2D/MeshInstance2D2
		var pp2 = p2.global_rotation
		b2.global_position = p2.global_position
		b2.apply_impulse(Vector2(1000,0).rotated(pp2))
		b2.bola = "energía_gravedad"
		get_parent().call_deferred("add_child", b2)
		
		
		var b3 = bola.instantiate()
		var p3 = $Skeleton2D/Bone2D2/Bone2D/Bone2D2/Bone2D3/Bone2D4/Bone2D5/Bone2D6/Node2D/MeshInstance2D3
		var pp3 = p3.global_rotation
		b3.global_position = p3.global_position
		b3.apply_impulse(Vector2(1000,0).rotated(pp3))
		b3.bola = "energía_gravedad"
		get_parent().call_deferred("add_child", b3)
		
		
		disparo = false


func _on_area_2d_2_area_entered(area):
	if area.get_parent().is_in_group("bala_player"):
		$AudioStreamPlayer2D.play()
		vida -= area.get_parent().dano
		if vida < 0.01 and muerto == false:
			emit_signal("brazo_caido")
			$AnimationPlayer.play("RESET")
			$AnimationPlayer.play("die")
			muerto = true
			if ataque == "ataque_laser":
				$Area2D.queue_free()
			

 
func _on_timer_timeout():
	if muerto == false:
		var rng = randi_range(Probabilidad.x,Probabilidad.y)
		if rng == 1 and activo == true:
			$AnimationPlayer.play(ataque)
		print(rng)

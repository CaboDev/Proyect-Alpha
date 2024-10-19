extends Node2D

var vida = 9
signal KO

var muerto = false
var vida_individual = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_brazo_1_brazo_caido():
	vida -= 1
	$"../Polpo/AnimationPlayer".play("new_animation")
	if vida == 7:
		$fase.play("inicio_de_fase_2")
	if vida == 3:
		$"brazo 1".Probabilidad = Vector2(1,1)
		$"brazo 2".Probabilidad = Vector2(1,1)
		$"brazo 3".Probabilidad = Vector2(1,1)
		$"brazo 4".Probabilidad = Vector2(1,1)
		$"brazo 3".ataque = "ataque_balas_fuerte"
		$"brazo 4".ataque = "ataque_balas_fuerte"
	if vida == 1:
		$"../Area2D/CollisionShape2D2".iniciar_fase_final()
		$"../Area2D/CollisionShape2D3".iniciar_fase_final()
		$"../Area2D/CollisionShape2D4".iniciar_fase_final()
		$"../Area2D/CollisionShape2D5".iniciar_fase_final()
		$"../Area2D/CollisionShape2D6".iniciar_fase_final()
		$"../Area2D/CollisionShape2D7".iniciar_fase_final()
		$"../Area2D/CollisionShape2D8".iniciar_fase_final()
		$"../Area2D/CollisionShape2D14".iniciar_fase_final()
		$"../Area2D/CollisionShape2D15".iniciar_fase_final()
		$"../Area2D/CollisionShape2D16".iniciar_fase_final()
		$"../Area2D/CollisionShape2D17".iniciar_fase_final()
		$"../Area2D/CollisionShape2D18".iniciar_fase_final()
		$"../Area2D/CollisionShape2D19".iniciar_fase_final()
		$"../StaticBody2D5/AnimationPlayer".play("final")

		
	if vida == 0:
		emit_signal("KO")


func _on_timer_timeout():
	if vida < 4 and vida > 1 and !$AnimationPlayer.is_playing():
		var rng = randi_range(1,4)
		match rng:
			1:
				$"../Area2D/CollisionShape2D2".emitir = true
				$"../Area2D/CollisionShape2D3".emitir = true
				$"../Area2D/CollisionShape2D4".emitir = true
				$"../Area2D/CollisionShape2D5".emitir = true
				$"../Area2D/CollisionShape2D6".emitir = true
				$"../Area2D/CollisionShape2D7".emitir = true
				$"../Area2D/CollisionShape2D8".emitir = true
				$"../Area2D/CollisionShape2D9".emitir = true
			2:
				$"../Area2D/CollisionShape2D10".emitir = true
				$"../Area2D/CollisionShape2D11".emitir = true
				$"../Area2D/CollisionShape2D12".emitir = true
				$"../Area2D/CollisionShape2D13".emitir = true
				$"../Area2D/CollisionShape2D14".emitir = true
				$"../Area2D/CollisionShape2D15".emitir = true
				$"../Area2D/CollisionShape2D16".emitir = true
				$"../Area2D/CollisionShape2D17".emitir = true
				$"../Area2D/CollisionShape2D18".emitir = true
				$"../Area2D/CollisionShape2D19".emitir = true
			3:
				$AnimationPlayer.play("der")
			4:
				$AnimationPlayer.play("iz")


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("bala_player"):
		$AudioStreamPlayer2D.play()
		vida_individual -= area.get_parent().dano
		if vida_individual < 0.01 and muerto == false:
			_on_brazo_1_brazo_caido()
			muerto = true
			

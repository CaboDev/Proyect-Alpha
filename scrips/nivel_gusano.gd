extends Node2D

var plat = preload("res://esenas/plataformas.tscn")
var fase = 0
@export var velocidad_de_plats : float = 500
var posiplata
var pp = false
var caro
var caro2

func _ready():
	if Save.hard_mode == false:
		$"boss/fase 1/AnimationTree".tree_root = load("res://esenas/plataformer/gusano/nivel_gusano.tres")
		$"boss/fase 2/AnimationTree2".tree_root = load("res://esenas/plataformer/gusano/fase 2.tres")
		$"boss/fase 3/espinas".wait_time = 2.5
	
	
	caro = $"boss/fase 1/sprites/MeshInstance2D/position"
	caro2 = $"boss/fase 2/sprites/MeshInstance2D/Node2D"
	posiplata = $"boss/fase 2/plataform_manager/Path2D/PathFollow2D"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fase == 1 and pp == false:
		$StaticBody2D2.position.y += velocidad_de_plats * delta
	if fase == 1:
		caro.global_position = caro2.global_position


func _on_boss_cambio_de_fase(value):
	fase = value
	if value == 1:
		$StaticBody2D2/AnimationPlayer.queue_free()
		$StaticBody2D2/Area2D.queue_free()
		$"boss/fase 1/MeshInstance2D/Area2D".queue_free()
		


func _on_tiempo_de_plataforma_timeout():
	posiplata.progress_ratio = randf_range(0, 1)
	if fase == 1:
		var b = plat.instantiate()
		b.position = posiplata.position
		b.velocidad_de_caida = velocidad_de_plats
		call_deferred("add_child", b)


func _on_visible_on_screen_notifier_2d_screen_exited():
	$StaticBody2D2.queue_free()
	pp = true





func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "fin de fase" or anim_name == "fin de fase2":
		$"boss/fase 1/AnimationTree".active = false
		$"boss/fase 2/AnimationTree2".active = true


func _on_animation_tree_2_animation_started(anim_name):
	if anim_name == "fin de fase":
		$Timer.start()
	elif anim_name == "inicio":
		$limites/AnimatedSprite2D4.play("salir")
		$limites/AnimatedSprite2D5.play("salir")
		$limites/AnimatedSprite2D6.play("salir")
		$limites/AnimatedSprite2D3.play("salir")
		$limites/AnimatedSprite2D2.play("salir")
		$limites/AnimatedSprite2D.play("salir")



func _on_timer_timeout():
	fase = 2
	


func _on_area_2d2_area_entered(area):
	pass # Replace with function body.

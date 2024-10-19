extends Node2D

signal ko
@export var fase = 1
var vida = 2100
@onready var playback : AnimationNodeStateMachinePlayback = $atacador/AnimationPlayer/AnimationTree.get("parameters/playback")

var vida_Max
func _ready():
	vida_Max = vida
	$atacador/AnimationPlayer/AnimationTree.active = true



func _process(delta):
	
	if vida < 1100 and fase == 1:
		playback.travel("iniciar_fase_2")




func _on_animation_tree_animation_finished(anim_name):
	
	
	if fase == 2:
		if anim_name == "idle_2":
			var rng = randi_range(1,6)
			
			
			
			match rng:
				1:
					playback.travel("ataque_rayos_der")
				2:
					playback.travel("ataque_rayos_iz")
				3:
					playback.travel("ataque_rayos_doble_horizontal")
				4:
					playback.travel("ataque_rayos_doble_vertical")
				5:
					playback.travel("ataque_rayos_doble_vertical")
				6:
					playback.travel("ataque_rayos_doble_horizontal_rriva")
			$digital_colisionador/AnimatedSprite2D.animation = "new_animation_2"
			$digital_colisionador/AnimatedSprite2D.play("new_animation_2")
	elif fase == 1:
		if anim_name == "idle_0_1":
			playback.travel("ataque_bolas")


func _on_digital_colisionador_area_entered(area):
	if area.get_parent().is_in_group("bala_player"):
		vida -= area.get_parent().dano
		if vida < 0.01:
			emit_signal("ko")
	

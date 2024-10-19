extends CanvasLayer

@export_file(".tscn") var siguiente_escena 
var mun = 1

func _ready():
	if Save.Mode_boss_rush == false:
		siguiente_escena = "res://esenas/main_menu.tscn"

func _on_boss_ko():
	if mun == 1:
		get_tree().get_nodes_in_group("spam")[0].queue_free()
		get_tree().get_nodes_in_group("musica")[0].stop()
		$Control/AnimationPlayer.play("new_animation")
		mun += 1
		Save.hard_mode = false


func _on_animation_player_animation_finished(anim_name):
	Save.save_data()
	get_tree().change_scene_to_file(siguiente_escena)

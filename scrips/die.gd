extends CanvasLayer



func _ready():
	$menu_cambios.muerto = false

func _process(delta):
	pass


func _on_main_menu_pressed():
	Save.hard_mode = false
	get_tree().change_scene_to_file("res://esenas/main_menu.tscn")


func _on_retry_pressed():
	get_tree().reload_current_scene()


func _game_over():
	$menu_cambios.muerto = true
	$moriste/VBoxContainer/retry.grab_focus()
	$AnimationPlayer.play("new_animation")


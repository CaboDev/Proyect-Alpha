extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/retri.grab_focus()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and get_parent().fin == false:
		pausa()

func pausa():
	if get_tree().paused == false:
		get_tree().paused = true
		show()
	elif get_tree().paused == true:
		get_tree().paused = false
		hide()
	$Control/retri.grab_focus()

func _on_retri_pressed():
	pausa()
	get_tree().reload_current_scene()


func _on_cont_pressed():
	pausa()


func _on_menu_pressed():
	Save.hard_mode = false
	pausa()
	get_tree().change_scene_to_file("res://esenas/main_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()

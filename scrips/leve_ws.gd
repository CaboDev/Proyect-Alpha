extends Node2D

@export var Nombre_del_nivel : String
@export var activo = false
@export_file(".tscn") var escena = "res://esenas/main_menu.tscn"
@export_enum("hard & normal", "only hard", "only normal", "enter") var modes : String



# Called when the node enters the scene tree for the first time.
func _ready():
	if modes == "only normal":
		$Node2D/HBoxContainer/Button2.hide()
		$Node2D/HBoxContainer2/Control2.hide()
	elif modes == "only hard":
		$Node2D/HBoxContainer/Button.hide()
		$Node2D/HBoxContainer2/Control.hide()
	elif modes == "enter":
		$Node2D/HBoxContainer/Button.text = "Enter"
		$Node2D/HBoxContainer/Button2.hide()
		$Node2D/HBoxContainer2/Control2.hide()
	
	
	$"125SinTítulo20240706154852".modulate = Save.settings.color_favorito
	$Label.text = Nombre_del_nivel
	$PointLight2D.color = Save.settings.color_favorito


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("ui_accept") && activo == true:
		$CanvasLayer/AnimationPlayer.play("0.5")
	elif event.is_action_pressed("x") && activo == true:
		if modes == "only hard" or modes == "hard & normal":
			Save.hard_mode = true
			$CanvasLayer/AnimationPlayer.play("0.5")

func _on_area_2d_body_entered(body):
	if body.name == "player_worl":
		$AnimationPlayer.play("abrir")


func _on_area_2d_body_exited(body):
	if body.name == "player_worl":
		$AnimationPlayer.play_backwards("abrir")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "0.5":
		get_tree().change_scene_to_file(escena)

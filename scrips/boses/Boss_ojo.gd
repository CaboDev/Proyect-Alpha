extends Node2D

signal cambio_de_fase
var fase_1 = false
var fase_2 = false
var fase : int = 6
var muerto = false
signal KO
@export var vida : float
@onready var playback : AnimationNodeStateMachinePlayback
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationTree.active = true
	playback = $AnimationTree.get("parameters/playback")
	$CanvasLayer/TextureProgressBar.max_value = vida
	$CanvasLayer/TextureProgressBar.value = vida


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("bala_player"):
		$AudioStreamPlayer2D.play()
		vida -= area.get_parent().dano
		$CanvasLayer/TextureProgressBar.value = vida
		if vida < 150 and fase_1 == false:
			fase = 5
			fase_1 = true
		if vida < 50 and fase_2 == false:
			fase_2 = true
			fase = 2
		if vida < 0.01 and muerto == false:
			emit_signal("KO")
			muerto = true


func _on_timer_timeout():
	playback.travel("laser")


func _game_over():
	pass

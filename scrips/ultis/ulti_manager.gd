extends Node2D

@export var disparar = false
@export_file("*.tscn") var ulti
var energy : float = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ulti_1"):
		if energy >29:
			$AnimationPlayer.play(Save.game_data.ULTI_EQUIPADA)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if disparar == true:
		#iniciar
		var ult = load(ulti)
		var b = ult.instantiate()
		#configurar
		b.global_position = $"..".global_position
		
		get_parent().get_parent().call_deferred("add_child",b)
		energy -= 30
		var tween : Tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		tween.tween_property($"../CanvasLayer/TextureProgressBar", "value", energy, 1)
		disparar = false


func _on_timer_timeout():
	energy += 30
	var tween : Tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property($"../CanvasLayer/TextureProgressBar", "value", energy, 1)

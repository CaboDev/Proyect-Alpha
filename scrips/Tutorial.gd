extends Node2D

var events = 2
var completado = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func Endedw():
	if events == 2:
		events -= 1
		$"aniciar batalla".play("iniciar_batalla")
	else :
		pass

func _on_pas_body_entered(body):
	if body.is_in_group("pliyir") && completado == false:
		$"aniciar batalla".play("new_animation")
		get_tree().get_nodes_in_group("musica")[0].stop()
		Dialogic.start("timeline_011")
		Dialogic.timeline_ended.connect(Endedw)
		
		completado = true

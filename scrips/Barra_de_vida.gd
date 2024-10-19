extends CanvasLayer

var vida_Max

# Called when the node enters the scene tree for the first time.
func _ready():
	vida_Max = get_parent().vida
	$ProgressBar.modulate = Save.settings.color_favorito
	calcular_vida_del_jefe()

func calcular_vida_del_jefe():
	var vida = get_parent().vida
	var porcentaje = (vida * 100)/vida_Max
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property($ProgressBar,"value", porcentaje, 1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	calcular_vida_del_jefe()

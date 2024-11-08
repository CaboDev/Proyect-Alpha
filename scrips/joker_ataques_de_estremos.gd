extends Path2D

@export var activo = false
@export var Gravedad : float = 0.3
@export var Rot : float
@export_enum("pica","corazon") var Type : String = "pica"
var bala = preload("res://esenas/plataformer/joker/cartas.tscn")

func _on_timer_timeout():
	if activo == true:
		$PathFollow2D.progress_ratio = randf_range(0,1)
		var b = bala.instantiate()
		b.global_position = $PathFollow2D.global_position
		b.Type = Type
		b.gravity_scale = Gravedad
		b.rotation_degrees = rad_to_deg((Rot*PI)/180)
		$"../../..".call_deferred("add_child",b)

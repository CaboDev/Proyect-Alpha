extends Path2D

@export var activo = false
@export var Gravedad : float = 0.3
@export var Rot : float
@export_enum("pica","corazon", "diamante", "trebol") var Type : String = "pica"
var bala = preload("res://esenas/plataformer/joker/cartas.tscn")
const BALA_2 = preload("res://esenas/bala2.tscn")

func _on_timer_timeout():
	if activo == true:
		$PathFollow2D.progress_ratio = randf_range(0,1)
		var b = bala.instantiate()
		b.global_position = $PathFollow2D.global_position
		b.Type = Type
		b.gravity_scale = Gravedad
		b.rotation_degrees = rad_to_deg((Rot*PI)/180)
		
		if Type == "diamante":
			global_position = get_tree().get_first_node_in_group("pliyir").global_position
			b.look_at(get_tree().get_first_node_in_group("pliyir").global_position)
			b.gravity_scale = 0
			b.apply_impulse(Vector2(1800,0).rotated(b.global_rotation))
			$"../../..".call_deferred("add_child",b)
			
		elif Type == "trebol":
			var b1 = BALA_2.instantiate()
			var b2 = BALA_2.instantiate()
			var b3 = BALA_2.instantiate()
			
			b1.global_position = $pointer.global_position
			b2.global_position = $pointer2.global_position
			b3.global_position = $pointer3.global_position
			
			b1.apply_impulse(Vector2(1800,0).rotated($"pointer".global_rotation))
			b2.apply_impulse(Vector2(1200,0).rotated($"pointer2".global_rotation))
			b3.apply_impulse(Vector2(1200,0).rotated($"pointer3".global_rotation))
			
			b1.modulate = Color.WHITE
			b2.modulate = Color.WHITE
			b3.modulate = Color.WHITE
			
			$"../../..".call_deferred("add_child",b1)
			$"../../..".call_deferred("add_child",b2)
			$"../../..".call_deferred("add_child",b3)
			
		else:
			$"../../..".call_deferred("add_child",b)

func _process(delta: float) -> void:
	if Type == "trebol":
		look_at(get_tree().get_first_node_in_group("pliyir").global_position)

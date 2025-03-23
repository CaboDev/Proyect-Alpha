extends Node2D

const BRAZO_MUSICAL_JOKER = preload("res://esenas/niveles/Brazo_Musical_joker.tscn")

func lanzar_caja(orientacion : String):
	var nodo_padre = get_node(orientacion)
	var b = BRAZO_MUSICAL_JOKER.instantiate()
	
	nodo_padre.call_deferred("add_child",b)
	b.global_position = get_tree().get_first_node_in_group(orientacion+"_f").global_position

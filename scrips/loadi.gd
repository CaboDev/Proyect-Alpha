extends Node2D

var bullet = preload("res://esenas/bola_de_fuego.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Node2D.look_at(get_tree().get_first_node_in_group("pliyir").global_position)


func _on_animation_player_animation_finished(anim_name):
	var b = bullet.instantiate()
	b.bola = "fuego_morao"
	b.rotation = $Node2D.rotation
	b.global_position = global_position
	b.apply_impulse(Vector2(1500,0).rotated($Node2D.rotation))
	get_parent().call_deferred("add_child",b)
	
	queue_free()

extends Node2D

@export var en_dash : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if en_dash == true:
		$Line2D.set_point_position(1 , $Baron_von_bots.global_position)

func _DAsh():
	en_dash = true
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property($Baron_von_bots, "global_position", get_tree().get_first_node_in_group("pliyir").global_position, 0.6)
	$Line2D.add_point($Baron_von_bots.global_position, 0)
	$Line2D.add_point($Baron_von_bots.global_position, 1)



func _Clear_pinnns():
	en_dash = false
	$Line2D.remove_point(1)
	$Line2D.remove_point(0)




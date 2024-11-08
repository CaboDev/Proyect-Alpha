extends Node2D

var bala = preload("res://esenas/plataformer/joker/cartas.tscn")
@export var en_Braxaso : bool
@export var B_or_W : int
var bullet_spe = 1000
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_tree().get_first_node_in_group("Brazo_N").look_at(get_tree().get_first_node_in_group("pliyir").global_position)
	get_tree().get_first_node_in_group("Brazo_B").look_at(get_tree().get_first_node_in_group("pliyir").global_position)
	
	
	$Posses/Path_Negro.curve.clear_points()
	$Posses/Path_Negro.curve.add_point($"Boss/Skeleton2D/main/brazo negro".global_position)
	$Posses/Path_Negro.curve.add_point(get_tree().get_first_node_in_group("Brazo_N").global_position)
	
	$Posses/Path_blanco.curve.clear_points()
	$Posses/Path_blanco.curve.add_point($"Boss/Skeleton2D/main/Brazo_blanco".global_position)
	$Posses/Path_blanco.curve.add_point(get_tree().get_first_node_in_group("Brazo_B").global_position)
	
	
	

func _Brazaso_preparacion():
	var rng = randi_range(1,4)
	B_or_W = randi_range(1,2)
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	tween.tween_property(self, "global_position", get_node("Boss/posis/"+str(rng)).global_position, 0.5)
	

func _retraer_Brazaso():
	var tween_05 = get_tree().create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	var tween_02 = get_tree().create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	tween_05.tween_property(get_tree().get_first_node_in_group("Brazo_N"), "global_position", $"Boss/Skeleton2D/main/brazo negro".global_position, 0.5)
	tween_02.tween_property(get_tree().get_first_node_in_group("Brazo_B"), "global_position", $"Boss/Skeleton2D/main/Brazo_blanco".global_position, 0.5)

func _Brazaso_Ya():
	var tween_5 = get_tree().create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	var player_pos = get_tree().get_first_node_in_group("pliyir").global_position
	
	if B_or_W == 1:
		tween_5.tween_property(get_tree().get_first_node_in_group("Brazo_N"), "global_position", player_pos, 0.5)
	else:
		tween_5.tween_property(get_tree().get_first_node_in_group("Brazo_B"), "global_position", player_pos, 0.5)


func _Brazaso_Terminado():
	var tween_5 = get_tree().create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	var tween_2 = get_tree().create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween_2.tween_property(get_tree().get_first_node_in_group("Brazo_N"), "global_position", Vector2(2000,760), 0.5)
	tween_5.tween_property(get_tree().get_first_node_in_group("Brazo_B"), "global_position", Vector2(1416,808), 0.5)
	
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", $Boss/posis/base.global_position, 0.5)

func _Disparar_de_la_mano():
	var rng = randi_range(1,2)
	var tipo
	var grupo = "Brazo_B"
	if B_or_W == 1: grupo = "Brazo_N"
	
	match rng:
		1:tipo = "trebol"
		2:tipo = "diamante"
	
	var b1 = bala.instantiate()
	b1.Type = tipo
	b1.global_position = get_tree().get_first_node_in_group(grupo).get_node("origen_1").global_position
	b1.global_rotation = get_tree().get_first_node_in_group(grupo).get_node("origen_1").global_rotation
	var b2 = bala.instantiate()
	b2.Type = tipo
	b2.global_position = get_tree().get_first_node_in_group(grupo).get_node("origen_2").global_position
	b2.global_rotation = get_tree().get_first_node_in_group(grupo).get_node("origen_2").global_rotation
	var b3 = bala.instantiate()
	b3.Type = tipo
	b3.global_position = get_tree().get_first_node_in_group(grupo).get_node("origen_3").global_position
	b3.global_rotation = get_tree().get_first_node_in_group(grupo).get_node("origen_3").global_rotation
	
	b1.apply_impulse(Vector2(bullet_spe,0).rotated(b1.global_rotation))
	b2.apply_impulse(Vector2(bullet_spe,0).rotated(b2.global_rotation))
	b3.apply_impulse(Vector2(bullet_spe,0).rotated(b3.global_rotation))
	
	get_parent().call_deferred("add_child",b1)
	get_parent().call_deferred("add_child",b2)
	get_parent().call_deferred("add_child",b3)

func _on_animation_player_fini(anim_name):
	if anim_name == "Static" or anim_name == "Static_2":
		$Boss/AnimationPlayer.play("Brazaso")
	else:
		$Boss/AnimationPlayer.play("Static")

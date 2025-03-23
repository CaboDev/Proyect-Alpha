extends Node2D

@export var los_cuatro : bool
var caida : int = -1100
var Encendido : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

func Manazo():
	if !los_cuatro:
		var posision = $Node2D2.global_position
		var tween_2 = get_tree().create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		tween_2.tween_property(%Mano, "global_position", posision, 0.5)

func Manazo_Retraer():
	if !los_cuatro:
		var posision = %Skeleton2D.global_position
		var tween_2 = get_tree().create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		tween_2.tween_property(%Mano, "global_position", posision, 0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$"Node2D/Skeleton2D/brazo negro/Bone2D/Bone2D/Bone2D/Bone2D/Bone2D/Bone2D/Area2D/CollisionShape2D".disabled = $Mano/Area2D/CollisionShape2D.disabled
	$"Node2D/Skeleton2D/brazo negro/Bone2D/Bone2D/Bone2D/Bone2D/Bone2D/Area2D/CollisionShape2D".disabled = $Mano/Area2D/CollisionShape2D.disabled
	$"Node2D/Skeleton2D/brazo negro/Bone2D/Bone2D/Bone2D/Bone2D/Area2D/CollisionShape2D".disabled = $Mano/Area2D/CollisionShape2D.disabled
	$"Node2D/Skeleton2D/brazo negro/Bone2D/Bone2D/Bone2D/Area2D/CollisionShape2D".disabled = $Mano/Area2D/CollisionShape2D.disabled
	$"Node2D/Skeleton2D/brazo negro/Bone2D/Bone2D/Area2D/CollisionShape2D".disabled = $Mano/Area2D/CollisionShape2D.disabled
	$"Node2D/Skeleton2D/brazo negro/Bone2D/Area2D/CollisionShape2D".disabled = $Mano/Area2D/CollisionShape2D.disabled
	$"Node2D/Skeleton2D/brazo negro/Area2D/CollisionShape2D".disabled = $Mano/Area2D/CollisionShape2D.disabled
	
	position.y -= caida * delta
	$Posses/Path_Negro.curve.clear_points()
	$Posses/Path_Negro.curve.add_point($"Node2D/Skeleton2D/brazo negro".global_position)
	$Posses/Path_Negro.curve.add_point(%Mano.global_position)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "new_animation":
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("world_pasurita"):
		if !Encendido == false:
			caida = 0
			$AnimationPlayer.play("new_animation")
		Encendido = true

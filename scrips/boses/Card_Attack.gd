extends Node2D

@export var Main_card : bool  = false
@export var joker : bool = false
@export var color_main : String
var vida : float = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Main_card == true and !joker == true:
		color_main = get_parent().get_parent().color_main
		
		var card_type : String
		var rng = randi_range(1,4)
		card_type = str(rng)+"_"+color_main
		$AnimatedSprite2D.play(card_type)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Main_card == true:
		%Card_1.global_rotation = 0
		%Card_1.global_scale = Vector2(1,1)
		%Card_2.global_rotation = 0
		%Card_2.global_scale = Vector2(1,1)
		%Card_3.global_rotation = 0
		%Card_3.global_scale = Vector2(1,1)
		%Card_4.global_rotation = 0
		%Card_4.global_scale = Vector2(1,1)
		%Card_Joker.global_rotation = 0
		%Card_Joker.global_scale = Vector2(1,1)
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("bala_player"):
		vida -= area.get_parent().dano
		if vida < 0.01:
			$AnimationPlayer/AnimationPlayer.play("new_animation_2")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "new_animation_2" or anim_name == "new_animation":
		queue_free()

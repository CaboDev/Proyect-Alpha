extends Node2D

signal KO

@export var vida : int = 1000
var fse = 1
const BOLA_DE_FUEGO = preload("res://esenas/bola_de_fuego.tscn")
@export var Attack = false
@export_enum("Ataque lanzarse", "Bolas azules", "laser", "Bolas rosas", "bolas_final_B", "bolas_final_P") var Ataque : String

@onready var playback : AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationTree.active = true

func saca_bola(color : Color, path : String, bala_vel):
	var b = BOLA_DE_FUEGO.instantiate()
	b.Color_del_luz = color
	b.bola = "araña_rosa"
	b.global_position = get_node(path+"/MeshInstance2D").global_position
	b.apply_impulse(Vector2(bala_vel,0).rotated(get_node(path+"/MeshInstance2D").global_rotation))
	get_parent().call_deferred("add_child", b)
	var b2 = BOLA_DE_FUEGO.instantiate()
	b2.Color_del_luz = color
	b2.bola = "araña_rosa"
	b2.global_position = get_node(path+"/MeshInstance2D2").global_position
	b2.apply_impulse(Vector2(bala_vel,0).rotated(get_node(path+"/MeshInstance2D2").global_rotation))
	get_parent().call_deferred("add_child", b2)
	var b3 = BOLA_DE_FUEGO.instantiate()
	b3.Color_del_luz = color
	b3.bola = "araña_rosa"
	b3.global_position = get_node(path+"/MeshInstance2D3").global_position
	b3.apply_impulse(Vector2(bala_vel,0).rotated(get_node(path+"/MeshInstance2D3").global_rotation))
	get_parent().call_deferred("add_child", b3)
	var b4 = BOLA_DE_FUEGO.instantiate()
	b4.Color_del_luz = color
	b4.bola = "araña_rosa"
	b4.global_position = get_node(path+"/MeshInstance2D4").global_position
	b4.apply_impulse(Vector2(bala_vel,0).rotated(get_node(path+"/MeshInstance2D4").global_rotation))
	get_parent().call_deferred("add_child", b4)
	

func _AttacK():
	match Ataque:
			"Ataque lanzarse":
				$Path2D/PathFollow2D.progress_ratio = randf_range(0,1)
				var tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
				tween.tween_property(self, "global_position", $Path2D/PathFollow2D.global_position, 0.5)
				tween.connect("finished", fin_del_aviso)
				$audio_player.play("01")
			"Bolas azules":
				saca_bola(Color(0,1,1), "posisiones_der", 1500)
			"Bolas rosas":
				saca_bola(Color(1,0,1), "posisiones_iz", -1500)
			"laser":
				%laser.play("new_animation")
				%laser1.play("default")
				%laser2.play("default")
				%laser3.play("default")
				%laser4.play("default")
				%laser5.play("default")
				%laser6.play("default")
				%laser7.play("default")
				%laser8.play("default")
				%laser9.play("default")
				%laser10.play("default")
			"bolas_final_B":
				pass
			"bolas_final_P":
				pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Attack == true:
		_AttacK()
		Attack = false
	
	
	
	
	$lines/Line2D.set_point_position(0 ,$Skeleton2D/Bone2D/Bone2D/cabeza.global_position)
	$lines/Line2D2.set_point_position(0 ,$Skeleton2D/Bone2D/Bone2D/pierna_der4/Bone2D.global_position)
	$lines/Line2D3.set_point_position(0 ,$Skeleton2D/Bone2D/Bone2D/pierna_der3/Bone2D.global_position)
	$lines/Line2D4.set_point_position(0 ,$Skeleton2D/Bone2D/Bone2D/pierna_der2/Bone2D.global_position)
	$lines/Line2D5.set_point_position(0 ,$Skeleton2D/Bone2D/Bone2D/pierna_der/Bone2D.global_position)
	$lines/Line2D6.set_point_position(0 ,$Skeleton2D/Bone2D/Bone2D/pierna_iz4/Bone2D.global_position)
	$lines/Line2D7.set_point_position(0 ,$Skeleton2D/Bone2D/Bone2D/pierna_iz3/Bone2D.global_position)
	$lines/Line2D8.set_point_position(0 ,$Skeleton2D/Bone2D/Bone2D/pierna_iz2/Bone2D.global_position)
	$lines/Line2D9.set_point_position(0 ,$Skeleton2D/Bone2D/Bone2D/pierna_iz/Bone2D.global_position)

func fin_del_aviso():
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", get_tree().get_first_node_in_group("pliyir").global_position, 0.6)
	tween.connect("finished", fin_del_aeaque_lanza)

func fin_del_aeaque_lanza():
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", Vector2(48,1080), 0.5)


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "idle" and fse == 1:
		var rng = randi_range(1,7)
		match rng:
			1:playback.travel("ataque laser_rosa")
			2:playback.travel("ataque laser_azul")
			3:playback.travel("ataque_bolas_rosa")
			4:playback.travel("ataque_bolas_rosa")
			5:playback.travel("ataque_1")
			6:playback.travel("ataque_1")
			7:playback.travel("ataque_1")


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("bala_player"):
		vida -= area.get_parent().dano
		if vida < 500 and fse < 2:
			fse += 1
			playback.travel("cambio de fase")
		if vida < 0.01 and fse < 3:
			emit_signal("KO")
			fse +=1
			playback.travel("final")
		

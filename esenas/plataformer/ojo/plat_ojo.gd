extends Node2D

var onuon : Vector2
var gravedad 
var laca = true
var boss

func  _ready():
	var time = randi_range(3, 6)
	$laser/Timer.wait_time = time
	print(time)
	boss = get_tree().get_nodes_in_group("boss")[0]
	var r = randi() % 2
	if r == 0:
		$AnimationPlayer.play("new_animation")
	elif  r == 1:
		$AnimationPlayer.play("new_animation_2")
	
	onuon.x = 1144
	onuon.y = -1640
	gravedad = ProjectSettings.get_setting("physics/2d/default_gravity")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.y += 0.1 * (gravedad * delta)




func _on_area_2d_area_entered(area):
	if area.is_in_group("Suelo_ene"):
		var r = randi() % 2
		if r == 0:
			$AnimationPlayer.play("new_animation")
		elif  r == 1:
			$AnimationPlayer.play("new_animation_2")
		position = onuon


func _on_timer_timeout():
	var r = randi() % boss.fase
	if r == 0:
		mandar_laser()


func mandar_laser():
	$"laser/AnimationPlayer".play("new_animation")

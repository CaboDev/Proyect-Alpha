extends Node2D

var on_screen = false
var vulnerable = true
@export var bullet_spe : float
@export var roti : float
@export var delay : float = 0.1
@export var sepx : float = 0
@export var sepy : float = 350
@export var vida : float = 4 
var bala = preload("res://esenas/bala2.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Timer.wait_time = delay
	position.y += sepy * delta
	position.x += sepx * delta




func _disparo():
	var a = bala.instantiate()
	a.rotation_degrees = rotation_degrees
	a.position = position
	a.apply_impulse(Vector2(bullet_spe,0).rotated(rotation+$lado.rotation))
	var b = bala.instantiate()
	
	b.rotation_degrees = rotation_degrees
	b.position = position
	b.apply_impulse(Vector2(bullet_spe,0).rotated(rotation+$lado2.rotation))
	var c = bala.instantiate()
	
	c.rotation_degrees = rotation_degrees
	c.position = position
	c.apply_impulse(Vector2(bullet_spe,0).rotated(rotation+$lado3.rotation))
	var d = bala.instantiate()
	
	d.rotation_degrees = rotation_degrees
	d.position = position
	d.apply_impulse(Vector2(bullet_spe,0).rotated(rotation+$lado4.rotation))
	var aa = bala.instantiate()
	

	
	get_parent().call_deferred("add_child", a)
	get_parent().call_deferred("add_child", b)
	get_parent().call_deferred("add_child", c)
	get_parent().call_deferred("add_child", d)




func _on_timer_timeout():
	if on_screen == true:
		_disparo()


func _on_visible_on_screen_notifier_2d_screen_exited():
	if vulnerable == false:
		queue_free()


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("bala_player"):
		vida -= area.get_parent().dano
		if vida < 0.01:
			queue_free()
		print(vida)


func _on_visible_on_screen_notifier_2d_screen_entered():
	on_screen =true


func _on_timer_2_timeout():
	vulnerable = false

extends Node2D

@export var bullet_spe : float
@export var roti : float
@export var sepx : float = 0
@export var sepy : float = 350
var ino = false

var vida = 4
var bala = preload("res://esenas/bala2.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += sepy * delta
	position.x += sepx * delta



func _disparo():
	var a = bala.instantiate()
	a.rotation_degrees = rotation_degrees
	a.position = position
	a.apply_impulse(Vector2(bullet_spe,0).rotated($"1".rotation))
	var b = bala.instantiate()
	
	b.rotation_degrees = rotation_degrees
	b.position = position
	b.apply_impulse(Vector2(bullet_spe,0).rotated($"2".rotation))
	var c = bala.instantiate()
	
	c.rotation_degrees = rotation_degrees
	c.position = position
	c.apply_impulse(Vector2(bullet_spe,0).rotated($"3".rotation))
	var d = bala.instantiate()
	
	d.rotation_degrees = rotation_degrees
	d.position = position
	d.apply_impulse(Vector2(bullet_spe,0).rotated($"4".rotation))
	var aa = bala.instantiate()
	
	aa.rotation_degrees = rotation_degrees
	aa.position = position
	aa.apply_impulse(Vector2(bullet_spe,0).rotated($"5".rotation))
	var ba = bala.instantiate()
	
	ba.rotation_degrees = rotation_degrees
	ba.position = position
	ba.apply_impulse(Vector2(bullet_spe,0).rotated($"6".rotation))
	var ca = bala.instantiate()
	
	ca.rotation_degrees = rotation_degrees
	ca.position = position
	ca.apply_impulse(Vector2(bullet_spe,0).rotated($"7".rotation))
	
	var da = bala.instantiate()
	da.rotation_degrees = rotation_degrees
	da.position = position
	da.apply_impulse(Vector2(bullet_spe,0).rotated($"8".rotation))
	
	get_parent().call_deferred("add_child", a)
	get_parent().call_deferred("add_child", b)
	get_parent().call_deferred("add_child", c)
	get_parent().call_deferred("add_child", d)
	get_parent().call_deferred("add_child", aa)
	get_parent().call_deferred("add_child", ba)
	get_parent().call_deferred("add_child", ca)
	get_parent().call_deferred("add_child", da)



func _on_timer_timeout():
	_disparo()


func _on_visible_on_screen_notifier_2d_screen_exited():
	if ino == true:
		queue_free()


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("bala_player"):
		vida -= area.get_parent().dano
		if vida < 0.01:
			queue_free()
		print(vida)



func _on_timer_2_timeout():
	ino = true

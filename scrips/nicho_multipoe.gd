extends Node2D

var bulet = preload("res://esenas/bala2.tscn")
@export var velocidad : float = 1300
@export var lanzado = false
@export var rotado = false
var _rotado = false
var spe : float = -1500

func _ready():
	if rotado == false:
		rotation_degrees = 0
	elif rotado == true:
		rotation_degrees = 180
	if _rotado == true:
		$pos/MeshInstance2D.rotation_degrees -= 90
		$pos/MeshInstance2D2.rotation_degrees -= 90
		$pos/MeshInstance2D3.rotation_degrees -= 90
		rotation_degrees = -90

func _physics_process(delta):
	if lanzado == true:
		if rotado == false:
			position.x += velocidad * delta
		elif rotado == true:
			position.x -= velocidad * delta
		if _rotado == true:
			position.y -= velocidad * delta
			position.x -= velocidad * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func disparo():
	if rotado == false:
		var b = bulet.instantiate()
		b.global_position = $pos.global_position
		b.apply_impulse(Vector2(spe,0).rotated($pos/MeshInstance2D.rotation))
		get_parent().call_deferred("add_child", b)

		var b2 = bulet.instantiate()
		b2.global_position = $pos.global_position
		b2.apply_impulse(Vector2(spe,0).rotated($pos/MeshInstance2D2.rotation))
		get_parent().call_deferred("add_child", b2)
		
		var b3 = bulet.instantiate()
		b3.global_position = $pos.global_position
		b3.apply_impulse(Vector2(spe,0).rotated($pos/MeshInstance2D3.rotation))
		get_parent().call_deferred("add_child", b3)
	elif rotado == true:
		var b = bulet.instantiate()
		b.global_position = $pos.global_position
		b.apply_impulse(Vector2(-spe,0).rotated($pos/MeshInstance2D.rotation))
		get_parent().call_deferred("add_child", b)

		var b2 = bulet.instantiate()
		b2.global_position = $pos.global_position
		b2.apply_impulse(Vector2(-spe,0).rotated($pos/MeshInstance2D2.rotation))
		get_parent().call_deferred("add_child", b2)
		
		var b3 = bulet.instantiate()
		b3.global_position = $pos.global_position
		b3.apply_impulse(Vector2(-spe,0).rotated($pos/MeshInstance2D3.rotation))
		get_parent().call_deferred("add_child", b3)


func _on_area_2d_body_entered(body):
	if body.is_in_group("pared_estomacal_gus"):
		disparo()

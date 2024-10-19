extends Node2D

@export var ppos : Vector2
var vida = 1000
@export var vele : bool
var valor = 1
signal KO
var ddd = 0
var muerto = false
var bala = preload("res://esenas/bulleto.tscn")
var prime = preload("res://esenas/bulleto_prime.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	print(Save.game_data["Boss 1"])
	ppos = $Marker2D.position
	pass # Replace with function body.

func _disparo():
	if muerto == false:
		var a = bala.instantiate()
		a.position = ppos
		a.sepy = -650
		a.sepx = -650
		var b = bala.instantiate()
		b.position = ppos
		b.sepy = 650
		b.sepx = -650
		var c = bala.instantiate()
		c.position = ppos
		c.sepy = 650
		c.sepx = 650
		var d = bala.instantiate()
		d.position = ppos
		d.sepy = -650
		d.sepx = 650
		var aa = bala.instantiate()
		aa.position = ppos
		aa.sepy = -1000
		aa.sepx = 0
		var ba = bala.instantiate()
		ba.position = ppos
		ba.sepy = 1000
		ba.sepx = 0
		var ca = bala.instantiate()
		ca.position = ppos
		ca.sepy = 0
		ca.sepx = 1000
		var da = bala.instantiate()
		da.position = ppos
		da.sepy = 0
		da.sepx = -1000
		
		get_parent().call_deferred("add_child", a)
		get_parent().call_deferred("add_child", b)
		get_parent().call_deferred("add_child", c)
		get_parent().call_deferred("add_child", d)
		get_parent().call_deferred("add_child", aa)
		get_parent().call_deferred("add_child", ba)
		get_parent().call_deferred("add_child", ca)
		get_parent().call_deferred("add_child", da)
		print("disoaro")
		ddd += 1
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CanvasLayer/TextureProgressBar.value = vida


func _on_recarga_timeout():
	ddd = 0


func _on_timer_2_timeout():
	if vele == true and ddd < valor:
		_disparo()
		


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("bala_player"):
		vida -= area.get_parent().dano
		$AudioStreamPlayer2D.play()
		if vida < 700:
			$AnimatedSprite2D.frame = 1
		if vida < 501:
			vele = true
			
		if vida < 400:
			$AnimatedSprite2D.frame = 2
		if vida < 101:
			valor = 2
			$AnimatedSprite2D.frame = 3
		if vida < 0.1:
			muerto = true
			Save.game_data["Boss 1"] = true
			emit_signal("KO")


func _on_prime_timeout():
	var b = prime.instantiate()
	b.global_position = $Marker2D2.global_position
	b.sepy = 200
	b.sepx = 0
	b.roti = 0.02
	b.bullet_spe = 1000
	b.vida = 10
	b.delay = 0.2
	get_parent().call_deferred("add_child", b)

extends Node2D

@export var inactive = false
@export var disparo = false
var vida = 100

var caca = false
var bullet = preload("res://esenas/bola_de_fuego.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Area2D".connect("area_entered", areaa)

func areaa(area):
	if area.get_parent().is_in_group("bala_player"):
		vida -= area.get_parent().dano
		$"../..".vida -= area.get_parent().dano
		if vida < 1:
			inactive = true
			
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if inactive == false:
		look_at($"../../../player_h".global_position)
		if disparo == true:
			var b = bullet.instantiate()
			b.bola = "digital"
			b.global_position = $"AnimatedSprite2D3/PointLight2D".global_position
			b.apply_impulse(Vector2(1000,0).rotated(rotation))
			get_parent().call_deferred("add_child", b)
			disparo = false
	else:
		if caca == false:
			$Area2D/CollisionShape2D.disabled = true
			$"GPUParticles2D".emitting = true
			$AnimatedSprite2D.hide()
			$AnimatedSprite2D2.hide()
			$AnimatedSprite2D3.hide()
			caca = true

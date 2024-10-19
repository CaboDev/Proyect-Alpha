extends Node2D

@export var lanzar_rayo = false

@export var rayo_ho = false

@onready var timer : Timer = Timer.new()
@onready var timer2 : Timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = 0.7
	timer.one_shot = true
	timer.timeout.connect(Timer_fuera)
	add_child(timer)
	timer2.wait_time = 1
	timer2.one_shot = true
	timer2.timeout.connect(Timer_fuera)
	add_child(timer2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lanzar_rayo == true:
		$AnimatedSprite2D.play()
		$AnimatedSprite2D2.play()
		$AnimatedSprite2D3.play()
		$AnimatedSprite2D4.play()
		if rayo_ho == true:
			$"AnimatedSprite2D6".play()
			$"AnimatedSprite2D5".play()
			
		
		timer.start()
		timer2.start()
		#0.4
		lanzar_rayo = false

func Timer_fuera():
	if $Area2D/CollisionShape2D.disabled == false:
		$Area2D/CollisionShape2D.disabled = true
	elif $Area2D/CollisionShape2D.disabled == true:
		$Area2D/CollisionShape2D.disabled = false
		$"AudioStreamPlayer2D".play()
		
	

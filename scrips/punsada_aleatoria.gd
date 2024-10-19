extends CollisionShape2D
@export var rango : Vector2
@export var emitir = false
var r2 = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = randf_range(rango.x, rango.y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if emitir == true:
		$AnimationPlayer.play("new_animation")
		emitir = false

func iniciar_fase_final():
	$AnimationPlayer.play("new_animation")
	$Timer.start()

func _on_timer_timeout():
	var r = randi() % r2
	if r == 0:
		$AnimationPlayer.play("new_animation")

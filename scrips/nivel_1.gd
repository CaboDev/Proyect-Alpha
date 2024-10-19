extends Node2D

var muerto = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$enemies.position.y += 450 * delta


func _on_timer_timeout():
	$CanvasLayer/ProgressBar.value += 1

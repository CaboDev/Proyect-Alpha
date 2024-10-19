extends Node2D

@export var velocidad_de_caida : float
@export var destruible = true
var delay = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var r = randi() % 2
	if r == 0:
		$StaticBody2D2/Plataforma.flip_h = false
		$AnimationPlayer.play("new_animation")
	elif r == 1:
		$StaticBody2D2/Plataforma.flip_h = true
		$AnimationPlayer.play("new_animation_2")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += velocidad_de_caida * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	if !velocidad_de_caida == 0:
		if delay == true:
			queue_free()


func _on_area_2d_area_entered(area):
	if destruible == true:
		if area.is_in_group("deest_plata"):
			queue_free()


func _on_timer_timeout():
	delay = true
		

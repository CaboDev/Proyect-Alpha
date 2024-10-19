extends CharacterBody2D

@export var laser = false
@export var sepy : int = -4000
@export var sepx : int = 0
@export var dano : float

func _ready():
	velocity.y = sepy
	velocity.x = sepx
# Get the gravity from the project settings to be synced with RigidBody nodes.


func _physics_process(delta):

	# Handle Jump.

	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("player"):
		queue_free()


func _on_araea_2d_area_entered(area):
	if laser == false:
		if area.get_parent().is_in_group("enemy"):
			queue_free()

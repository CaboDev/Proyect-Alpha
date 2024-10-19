extends RigidBody2D

var thrust = Vector2(0, -1250)
var torque = 200

func _ready():
	pass
# Get the gravity from the project settings to be synced with RigidBody nodes.


func _physics_process(delta):
	pass




func _on_area_2d_area_entered(area):
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_2d_body_entered(body):
	if body.name == "esc":
		queue_free()

extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionx = Input.get_axis("ui_left", "ui_right")
	if directionx:
		velocity.x = directionx * SPEED
		$AnimatedSprite2D.play("x_"+str(directionx))
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var directiony = Input.get_axis("ui_up", "ui_down")
	if directiony:
		velocity.y = directiony * SPEED
		$AnimatedSprite2D.play("y_"+str(-directiony))
	else:
		if !directionx :
			$AnimatedSprite2D.play("new_animation")
		velocity.y = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

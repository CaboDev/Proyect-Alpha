extends CharacterBody2D

@export var vida : float = 100
var lado = -1
@export var SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var player = get_tree().get_first_node_in_group("player")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func cambio_de_lado():
	scale.x = scale.x * -1

func _physics_process(delta):
	
	
	
	velocity.x = -lado * SPEED
	
	move_and_slide()
	





func _on_animation_tree_animation_started(anim_name):
	if player.global_position.x > global_position.x:
		lado = -1
	
	else:
		lado = 1
	$Skeleton2D.scale.x = 2 * lado

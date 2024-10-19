extends AnimatedSprite2D

@export var action : String

# Called when the node enters the scene tree for the first time.
func _ready():
	if !action == "":
		var control = InputMap.action_get_events(action)[0]
		if control is InputEventJoypadButton:
			play("b "+str(control.button_index))
		elif control is InputEventJoypadMotion:
			play("a "+str(control.axis))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

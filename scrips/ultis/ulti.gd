extends RigidBody2D
@export_group("ulti")
@export_enum("explosion", "electric lateral", "superior_1") var Type
@export var dano : float = 40
@export var borrar = false
# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Save.settings.color_favorito


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
		
	if borrar == true:
		queue_free()

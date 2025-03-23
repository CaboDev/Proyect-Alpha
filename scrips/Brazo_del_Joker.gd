extends Bone2D

@export var camino : Node
@export var ID_de_bola : float = 1
@export var Cantidad_de_bolas : float = 7
var progreso : float

func _ready():
	pass


func _process(delta):
	progreso = (1/Cantidad_de_bolas)*ID_de_bola
	camino.progress_ratio = progreso
	global_position = camino.global_position

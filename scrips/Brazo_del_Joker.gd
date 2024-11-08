extends Bone2D

@export_enum("Blanco","Negro") var color : int = 1
@export var ID_de_bola : float = 1
@export var Cantidad_de_bolas : float = 7
var camino 
var progreso : float

func _ready():
	camino = get_tree().get_first_node_in_group("Braxo_camino").get_child(color).get_child(0)


func _process(delta):
	progreso = (1/Cantidad_de_bolas)*ID_de_bola
	camino.progress_ratio = progreso
	global_position = camino.global_position

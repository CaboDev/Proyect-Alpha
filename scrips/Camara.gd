extends Camera2D

@export var randistri : float = 50.0
@export var sakefase : float = 0.5

var rng = RandomNumberGenerator.new()

var shakestre: float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func a_plichake():
	shakestre = randistri

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shakestre > 0:
		shakestre = lerpf(shakestre,0,sakefase * delta)
		
		offset = rando_ofse()

func rando_ofse() -> Vector2:
	return Vector2(rng.randf_range(-shakestre,shakestre),rng.randf_range(-shakestre,shakestre))

extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgressBar.self_modulate = Save.settings.color_favorito
	$"../Node2D/GPUParticles2D5".self_modulate = Save.settings.color_favorito
	$"../Node2D/GPUParticles2D6".self_modulate = Save.settings.color_favorito
	$Ui.modulate = Save.settings.color_favorito
	$MeshInstance2D.material.set_shader_parameter("ring_color",Save.settings.color_favorito)
	var aas = Save.settings.color_favorito
	aas -= Color.GRAY
	var add = Save.settings.color_favorito
	add -= Color.DARK_GRAY 
	$MeshInstance2D.material.set_shader_parameter("empty_cell_color",aas)
	$MeshInstance2D.material.set_shader_parameter("bg_line_color",add)
	

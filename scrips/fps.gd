extends CanvasLayer


func _process(delta):
	var fps = Engine.get_frames_per_second()
	$Label.text = "FPS: "+str(fps)
	if fps > 25:
		$Label.modulate = Color.GREEN
	elif fps > 20:
		$Label.modulate = Color.ORANGE
	elif fps > 15:
		$Label.modulate = Color.RED

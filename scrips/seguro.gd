extends Panel

signal si

func iniciar():
	show()
	$no.grab_focus()

func _on_si_pressed():
	emit_signal("si")
	hide()


func _on_no_pressed():
	hide()

extends Control

signal back

func _recibir_focus():
	$butones/Ingles.grab_focus()

func _on_ingles_pressed() -> void:
	TranslationServer.set_locale("en")

func _on_español_pressed() -> void:
	TranslationServer.set_locale("es")

func _on_japones_pressed() -> void:
	TranslationServer.set_locale("ja")


func _on_atras__pressed() -> void:
	emit_signal("back")

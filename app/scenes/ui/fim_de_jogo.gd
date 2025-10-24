extends CanvasLayer

func _on_reiniciar_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_sair_pressed():
	get_tree().quit()

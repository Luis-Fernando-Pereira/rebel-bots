extends Control


func _ready() -> void:
	$Iniciar.visible = true
	$Reiniciar.visible = false
	$Menu.visible = false


func _process(_delta: float) -> void:
	if Global.jogo_terminou && !$Reiniciar.visible:
		$Reiniciar.visible = true 
		$Menu.visible = true


func _on_iniciar_pressed() -> void:
	$Iniciar.visible = false
	Global.play = true


func _on_reiniciar_pressed() -> void:
	Global.jogo_terminou = false
	Global.play = false
	get_tree().reload_current_scene()


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://app/scenes/ui/title_screen.tscn")

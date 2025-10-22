extends Control


func _ready() -> void:
	$BotaoIniciar.visible = true
	$BotaoReiniciar.visible = false
	$BotaoMenu.visible = false
	$LabelNivelConcluido.visible = false
	$LabelNivelFalhado.visible = false


func _process(_delta: float) -> void:
	if Global.jogo_terminou:
		$BotaoReiniciar.visible = true 
		$BotaoMenu.visible = true
		
		if Global.nivel_vencido:
			$LabelNivelConcluido.visible = true
		else:
			$LabelNivelFalhado.visible = true
			


func resetar_variaveis_globais():
	Global.jogo_terminou = false
	Global.play = false
	Global.nivel_vencido = false
	


func _on_iniciar_pressed() -> void:
	$BotaoIniciar.visible = false
	Global.play = true


func _on_reiniciar_pressed() -> void:
	resetar_variaveis_globais()
	get_tree().reload_current_scene()


func _on_menu_pressed() -> void:
	resetar_variaveis_globais()
	get_tree().change_scene_to_file("res://app/scenes/ui/title_screen.tscn")

extends Control


func _ready() -> void:
	$BotaoProximoNivel.visible = false
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
			$BotaoProximoNivel.visible = true
			$LabelNivelConcluido.visible = true
		else:
			$LabelNivelFalhado.visible = true
			#$GameOverSound.play()
	
	if Global.creditos:
		$BotaoIniciar.visible = false
		$BotaoProximoNivel.visible = false
		$BotaoReiniciar.visible = false
		$BotaoMenu.visible = true
	


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
	Global.resetar_todos_os_niveis(get_tree())

func _on_button_pressed() -> void:
	resetar_variaveis_globais()
	Global.ir_para_proximo_nivel(get_tree())


func _on_botao_menu_mouse_entered() -> void:
	playHoverSound()


func _on_botao_reiniciar_mouse_entered() -> void:
	playHoverSound()


func _on_botao_iniciar_mouse_entered() -> void:
	playHoverSound()


func _on_botao_proximo_nivel_mouse_entered() -> void:
	playHoverSound()


func playHoverSound():
	$HoverSound.play()

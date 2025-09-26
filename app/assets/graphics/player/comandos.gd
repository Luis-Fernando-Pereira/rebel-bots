extends Control

signal comando_encaixado(comando: Comando)

func _on_mover_para_frente_comando_encaixado(comando: Comando) -> void:
	comando_encaixado.emit(comando)

func _on_virar_comando_encaixado(comando: Comando) -> void:
	comando_encaixado.emit(comando)

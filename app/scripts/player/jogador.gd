extends Node2D

var is_open = false



func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("i"):
		if is_open:
			fechar()
		else:
			abrir()

func abrir():
	visible = true
	is_open = true

func fechar():
	visible = false
	is_open = false

func _on_encaixes_comando_encaixado(encaixe: int, comando: Comando) -> void:
	pass

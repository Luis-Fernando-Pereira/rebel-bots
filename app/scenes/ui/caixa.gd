# Caixa.gd
extends Area2D

# Variável para sabermos se o objeto está sendo carregado pelo robô.
var esta_sendo_carregado: bool = false

func _ready() -> void:
	# Adiciona a si mesmo ao grupo 'pegavel' para ser facilmente identificado.
	add_to_group("pegavel")

extends Node2D

@export var robo: Area2D
@export var tela_game_over: CanvasLayer
@export var area_vitoria: Area2D
@export var proxima_fase: String

func _ready():
	robo.morreu.connect(_on_robo_morreu)

	area_vitoria.vitoria_alcancada.connect(_on_vitoria)

func _on_robo_morreu():
	tela_game_over.show()
	
	get_tree().paused = true

func _on_vitoria():
	get_tree().paused = false

	if not proxima_fase.is_empty():
		get_tree().call_deferred("change_scene_to_file", proxima_fase)
	else:
		print("ERRO: Vitória alcançada no Level01, mas a variável 'Proxima Fase' não foi definida no Inspetor!")

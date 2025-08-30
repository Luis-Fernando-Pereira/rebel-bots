extends Node2D

var comandos = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

func _on_body_entered(body: Node2D) -> void:
	pass


func _on_encaixe_instrucao_emitida(instrucao: Instrucao) -> void:
	print(instrucao.comando.comando, instrucao.encaixe)

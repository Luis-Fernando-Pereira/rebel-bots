extends StaticBody2D

signal instrucao_emitida(instrucao:Instrucao)

@export var encaixe :int

func _ready() -> void:
	modulate = Color(Color.MEDIUM_PURPLE, 0.7) 

func _process(_delta: float) -> void:
	if Global.esta_arrastando:
		visible = true
	else: 
		visible = false


func _on_item_comando_emitido(comando: Comando) -> void:
	var instrucao = Instrucao.new()
	instrucao.comando = comando
	instrucao.encaixe = encaixe
	
	print(instrucao)
	instrucao_emitida.emit(instrucao)

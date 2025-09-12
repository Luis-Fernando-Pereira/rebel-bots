extends Area2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var instrucoes: Array[Instrucao] = []
var instrucao_em_execucao: Instrucao

var fabrica_instrucao: Instrucao = Instrucao.new()

var terminar_execucao:= false

var posicao_futura = null
var mover: float = 0
var rotacao: float = 0
var direcao:= Vector2.RIGHT
@export var velocidade := 200.0
var estado := Global.Estado.IDLE


func _ready() -> void:
	instrucoes.resize(9)

func _process(delta: float) -> void:
	if Global.play:
		if instrucao_em_execucao == null:
			processar_fila()
		else:
			preparar_para_execucao()
			
		if deve_parar_execucao():
			parar_execucao()


func deve_parar_execucao() -> bool:
	return estado == Global.Estado.FINALIZADO


func parar_execucao() -> void:
	Global.play = false


func processar_fila() -> void: 
	if instrucoes:
		while instrucoes.size() > 0:
			instrucao_em_execucao = instrucoes.pop_front()
			
			if instrucao_em_execucao != null:
				return
		
		if instrucao_em_execucao == null:
			finalzar_execucao()
	else:
		finalzar_execucao()


func finalzar_execucao() -> void:
	estado = Global.Estado.FINALIZADO  


func preparar_para_execucao():
	print(position)
	posicao_futura = position
	for i in range(instrucao_em_execucao.comando.repetir):
		match instrucao_em_execucao.comando.tipo:
			Comando.TipoComando.MOVER_PARA_FRENTE:
				mover_frente()
			Comando.TipoComando.VIRAR:
				virar()
			Comando.TipoComando.PEGAR:
				pegar()
			Comando.TipoComando.LARGAR:
				largar()
	instrucao_em_execucao = null
	posicao_futura = null
	print(position)


# Funções de ação (substitua com lógica real)
func mover_frente():
	var tween = get_tree().create_tween()
	
	match direcao:
		Global.direita:
			posicao_futura.x += Global.unidade_de_movimento
			mover_robo(tween, posicao_futura)
			
		Global.esquerda:
			posicao_futura = position
			posicao_futura.x -= Global.unidade_de_movimento
			mover_robo(tween, posicao_futura)
			
		Global.baixo:
			posicao_futura = position
			posicao_futura.y += Global.unidade_de_movimento
			mover_robo(tween, posicao_futura)
			
		Global.cima:
			posicao_futura = position
			posicao_futura.y -= Global.unidade_de_movimento
			mover_robo(tween, posicao_futura)


func mover_robo(tween, posicao) -> void:
	tween.tween_property(self, "position", posicao, 2)


func virar():
	direcao = instrucao_em_execucao.comando.direcao


func pegar():
	pass


func largar():
	pass


func condicao_valida(valor: bool) -> void:
	if condicao_para_executar_comando_atual() && valor:
		pass


func condicao_para_executar_comando_atual() -> bool:
	if instrucao_em_execucao.comando.executar_se_condicao_verdadeira:
		return true
	else:
		return false


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if !$Encaxes.visible:
			$Encaxes.visible = true
			$Encaxes.z_index += z_index + 1


func _on_encaxes_lista_de_comandos_alterado(lista_de_comandos: Variant) -> void:
	
	for index in range(instrucoes.size()):
		var comando = lista_de_comandos.get(index)
		
		if comando != null:
			instrucoes.set(index, fabrica_instrucao.nova_instrucao(comando))


func _on_area_de_deteccao_de_obstaculos_body_entered(body: Node2D) -> void:
	pass
		

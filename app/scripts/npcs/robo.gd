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
var executar_instrucao = false

const DIRECOES = {
	Global.direita: Vector2.RIGHT,
	Global.esquerda: Vector2.LEFT,
	Global.cima: Vector2.UP,
	Global.baixo: Vector2.DOWN
}

var modificador_direcao: int = 1  # pode ser 1 (normal), -1 (inverter), ou até >1 pra andar mais

func _ready() -> void:
	instrucoes.resize(9)
	
	print(position)


func _process(delta: float) -> void:
	posicao_futura = position
	if Global.play:	
		var tween = get_tree().create_tween()
		
		if instrucao_em_execucao == null:
			print("processou fila")
			
			processar_fila()
			executar_instrucao = true
		
		if instrucao_em_execucao:
			print("criou tween")
			
			if executar_instrucao:
				print("executou")
				preparar_para_execucao()
				print("pos_futura: ", posicao_futura)
				mover_robo(tween, posicao_futura)
				print("moveu personagem")
				executar_instrucao = false
			
			if tween.is_running():
				await tween.finished
				
			if tween.finished:
				print("finzalizou tween")
				position = posicao_futura
				print("pos: ", position)
				instrucao_em_execucao = null
				posicao_futura = null
		
		if deve_parar_execucao():
			print("parou")
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


func mover_frente():
	if direcao in DIRECOES:
		var deslocamento = DIRECOES[direcao] * Global.unidade_de_movimento * modificador_direcao
		posicao_futura += deslocamento


func mover_robo(tween, posicao) -> void:
	tween.tween_property(self, "position", posicao, 0.5)


func virar():
	match instrucao_em_execucao.comando.direcao:
		Global.Direcoes.ESQUERDA:
			direcao = Global.esquerda
		Global.Direcoes.DIREITA:
			direcao = Global.direita
		Global.Direcoes.CIMA:
			direcao = Global.cima
		Global.Direcoes.BAIXO:
			direcao = Global.baixo


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
	if body.is_in_group("pegavel"):
		pass

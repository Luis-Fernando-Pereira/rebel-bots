extends Area2D

var instrucoes: Array[Instrucao] = []
var instrucao_em_execucao: Instrucao

var fabrica_instrucao: Instrucao = Instrucao.new()

var posicao_futura = null
var direcao:= Vector2.RIGHT
@export var velocidade := 100
var estado := Global.Estado.IDLE
var executar_instrucao = false
var pos_pre_comando: Vector2
var movimento: Vector2

const DIRECOES = {
	Global.direita: Vector2.RIGHT,
	Global.esquerda: Vector2.LEFT,
	Global.cima: Vector2.UP,
	Global.baixo: Vector2.DOWN,
	Global.parar: Vector2.ZERO
}

var modificador_direcao: int = 1  # pode ser 1 (normal), -1 (inverter), ou até >1 pra andar mais

func _ready() -> void:
	instrucoes.resize(9)
	print(position)


func _process(delta: float) -> void:
	if Global.play:
		if pode_processar_fila():
			processa_fila()
			executar_instrucao = true
		
		if instrucao_em_execucao:
			if executar_instrucao:
				await executar()
				executar_instrucao = false
			
			if nao_esta_na_posicao_futura(delta):
				mover(delta)
			else:
				parar()


func pode_processar_fila() -> bool:
	return nao_esta_executando_instrucao() && fila_possui_instrucoes()


func fila_possui_instrucoes() -> bool:
	if instrucoes:
		return true
	return false


func nao_esta_executando_instrucao() -> bool:
	return instrucao_em_execucao == null


func nao_esta_na_posicao_futura(delta) -> bool:
	return position.distance_to(posicao_futura) > velocidade * delta


func mover(delta):
	position += movimento * delta

func parar():
	position = posicao_futura
	instrucao_em_execucao = null
	movimento = Vector2.ZERO


func executar() -> void:
	print("excecutou comando")
	pos_pre_comando = position
	await preparar_para_execucao()


func processa_fila() -> void:
	if fila_possui_instrucoes():
		while instrucoes.size() > 0:
			instrucao_em_execucao = instrucoes.pop_front()
			
			if instrucao_em_execucao != null:
				return


func preparar_para_execucao():
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
	var passos = instrucao_em_execucao.comando.repetir * Global.unidade_de_movimento
	var deslocamento = DIRECOES[direcao] * passos * modificador_direcao
	posicao_futura = pos_pre_comando + deslocamento
	
	var direcao_mov = deslocamento.normalized()
	movimento = direcao_mov * velocidade
	
	print("posicao futura: ", posicao_futura)


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
	
	print("virou")


func pegar():
	pass


func largar():
	pass


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
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

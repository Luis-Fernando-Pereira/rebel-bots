extends Area2D

var instrucoes: Array[Instrucao] = []
var instrucao_em_execucao: Instrucao

var posicao_futura = null
var direcao:= Vector2.RIGHT
@export var velocidade := 100
var estado := Global.Estado.IDLE

var objetos_proximos: Array[Area2D] = []
var objeto_carregado: Area2D = null

var executar_instrucao = false
var pos_pre_comando: Vector2
var movimento: Vector2

@export var delay_comando: float = 0.5
var em_delay = false
var is_animating = false

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
	


func _process(delta: float) -> void:
	if Global.play:
		if !is_animating:
			is_animating = true
			$AnimacaoDoRobo.play()
		
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
		
		if not fila_possui_instrucoes() and not em_delay and nao_esta_executando_instrucao():
			print("chegou")
			print(instrucoes)
			Global.play = false
			Global.jogo_terminou = true


func pode_processar_fila() -> bool:
	return not em_delay and nao_esta_executando_instrucao() and fila_possui_instrucoes()


func fila_possui_instrucoes() -> bool:
	for instrucao in instrucoes:
		if instrucao != null:
			return true
	
	return false

func nao_esta_executando_instrucao() -> bool:
	return instrucao_em_execucao == null


func nao_esta_na_posicao_futura(delta) -> bool:
	return position.distance_to(posicao_futura) > velocidade * delta


func mover(delta):
	position += movimento * delta

func parar():
	if instrucao_em_execucao != null and not em_delay:
		position = posicao_futura
		movimento = Vector2.ZERO
		estado = Global.Estado.IDLE
		
		# libera a instrução atual
		instrucao_em_execucao = null
		
		# marca que entrou em delay
		em_delay = true
		await get_tree().create_timer(delay_comando).timeout
		em_delay = false
		$AnimacaoDoRobo.stop()
		is_animating = false


func executar() -> void:
	
	pos_pre_comando = position
	await preparar_para_execucao()


func processa_fila() -> void:
	
	if fila_possui_instrucoes():
		while instrucoes.size() > 0:
			instrucao_em_execucao = instrucoes.pop_front()
			
			if instrucao_em_execucao != null:
				return
	else:
		Global.play = false
		Global.jogo_terminou = true


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
	var deslocamento = direcao * passos * modificador_direcao  # agora usa Vector2 direto
	
	movimento = deslocamento.normalized() * velocidade  # velocidade constante
	posicao_futura = position + deslocamento


func virar():
	print("Esquerda:",Global.Direcoes.ESQUERDA)
	print("Direita:",Global.Direcoes.DIREITA)
	print("Cima:",Global.Direcoes.CIMA)
	print("Baixo:",Global.Direcoes.BAIXO)
	print("direção atual:",instrucao_em_execucao.comando.direcao)
	print("",instrucao_em_execucao.comando.direcao)
	match instrucao_em_execucao.comando.direcao:
		Global.Direcoes.ESQUERDA:
			direcao = Vector2.LEFT
		Global.Direcoes.DIREITA:
			direcao = Vector2.RIGHT
		Global.Direcoes.CIMA:
			direcao = Vector2.UP
		Global.Direcoes.BAIXO:
			direcao = Vector2.DOWN

	
	


func pegar():
	movimento = Vector2.ZERO
	if objeto_carregado == null and not objetos_proximos.is_empty():
		var objeto_a_pegar = objetos_proximos[0]
		
		if objeto_a_pegar.is_in_group("pegavel"):
			
			objeto_carregado = objeto_a_pegar
			
			objeto_carregado.get_parent().remove_child(objeto_carregado)
			self.add_child(objeto_carregado)
			
			objeto_carregado.position = Vector2(60, 0)
			
			objeto_carregado.esta_sendo_carregado = true
			


func largar():
	if objeto_carregado != null:
		
		var objeto_a_largar = objeto_carregado
		var cena_principal = get_tree().current_scene
		
		self.remove_child(objeto_a_largar)
		
		cena_principal.add_child(objeto_a_largar)
		
		objeto_a_largar.global_position = self.global_position + direcao.normalized() * 80
		
		objeto_a_largar.esta_sendo_carregado = false
		
		objeto_carregado = null


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseMotion and Global.esta_arrastando:
		altera_visibilidade_paleta_de_comandos()
	
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		altera_visibilidade_paleta_de_comandos()


func altera_visibilidade_paleta_de_comandos():
	if !$Encaxes.visible:
			$Encaxes.visible = true
			$Encaxes.z_index += z_index + 1

func _on_encaxes_lista_de_comandos_alterado(lista_de_comandos: Variant) -> void:
	
	for index in range(instrucoes.size()):
		var comando = lista_de_comandos.get(index)
		
		if comando != null:
			instrucoes.set(index, Instrucao.new().nova_instrucao(comando))


func _on_area_de_deteccao_de_obstaculos_body_entered(_body: Node2D) -> void:
	pass


func _on_area_de_interacao_area_entered(area: Area2D) -> void:
	if area.is_in_group("pegavel") and not area in objetos_proximos:
		objetos_proximos.append(area)


func _on_area_de_interacao_area_exited(area: Area2D) -> void:
	if area in objetos_proximos:
		objetos_proximos.erase(area)


func _on_encaxes_mouse_exited() -> void:
	if Global.esta_arrastando:
		altera_visibilidade_paleta_de_comandos()

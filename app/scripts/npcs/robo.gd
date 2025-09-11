extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var instrucoes: Array[Instrucao] = []
var instrucao_em_execucao: Instrucao

var fabrica_instrucao: Instrucao = Instrucao.new()

var terminar_execucao:= false

var mover: float = 0
var rotacao: float = 0
var direcao:= Global.direita
@export var velocidade := 200.0
var estado := Global.Estudo.IDLE

func _ready() -> void:
	instrucoes.resize(9)

func _physics_process(delta: float) -> void:
	
	if Global.play:
			
		if instrucao_em_execucao == null:
			processar_fila()
		else:
			executar()
		
		parar_execucao()


func parar_execucao() -> void:
	if estado == Global.Estudo.FINALIZADO:
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
	estado = Global.Estudo.FINALIZADO  

# Método para execução do comando (pode ser chamado pelo personagem)
func executar():
	print(instrucao_em_execucao)
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
		
	print(instrucoes)


# Funções de ação (substitua com lógica real)
func mover_frente():
	#mover += Global.unidade_de_movimento
	if direcao != Vector2.ZERO:
		velocity = direcao.normalized() * velocidade
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func virar():
	direcao = instrucao_em_execucao.comando.direcao
	#rotacao += Global.unidade_de_movimento
	print("Virando")

func pegar():
	print("Pegando objeto")

func largar():
	print("Largando objeto")


func condicao_valida(valor: bool) -> void:
	if condicao_para_executar_comando_atual() && valor:
		pass
		#match instrucao_em_execucao.comando.condicao:
			#Comando.Condicao.OBSTACULO


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
	if body is StaticBody2D:
		var direcao = velocity.normalized() if velocity.length() > 0 else Vector2.ZERO
		var vetor_ate_body = (body.global_position - global_position).normalized()
		
		var dot = direcao.dot(vetor_ate_body)
		
		if dot > 0.5: # maior que 0.5 = mais alinhado à frente
			instrucao_em_execucao.comando.obstaculo_a_frente = true
			print("StaticBody está no caminho à frente!")
		else:
			print("StaticBody não está na direção do movimento")

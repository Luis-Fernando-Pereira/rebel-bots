extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var instrucoes: Array[Instrucao] = []
var instrucao_em_execucao: Instrucao = Instrucao.new()

var fabrica_instrucao: Instrucao = Instrucao.new()
var index_instrucao_em_execucao: int = 1
var terminou_de_executar_instrucao: bool = false

func _ready() -> void:
	instrucoes.resize(10)

func _physics_process(delta: float) -> void:
	
	if instrucao_em_execucao == null:
		for instrucao in instrucoes:
			if instrucao.em_execucao:
				var comando = instrucao.comando
				if comando.condicao_válida():
					comando.executar()
					instrucao.em_execucao = false
					index_instrucao_em_execucao += 1
					instrucoes.get(index_instrucao_em_execucao).em_execucao = true
	
	if Global.play:
		instrucao_em_execucao
	
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if !$Encaxes.visible:
			$Encaxes.visible = true
			$Encaxes.z_index += z_index + 1


func _on_encaxes_lista_de_comandos_alterado(lista_de_comandos: Variant) -> void:
	var index = 1
	
	for instrucao in instrucoes:
		var comando = lista_de_comandos.get(index)
		
		if comando != null:
			instrucoes.set(index, fabrica_instrucao.nova_instrucao(comando))
		
		index += 1

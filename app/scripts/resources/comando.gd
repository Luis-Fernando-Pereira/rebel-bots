extends Resource
class_name Comando

# Permite exportar no editor
@export var nome: String
@export var tipo: TipoComando = TipoComando.MOVER_PARA_FRENTE
@export var textura: Texture2D

# Condição opcional (pode ser script ou string para simplificação)
@export var condicao: Condicao

# Laço de repetição opcional
@export var repetir: int = 1  # 1 = executar uma vez

@export var rotacionar: int = 0

var obstaculo_a_frente: bool = false

var executar_se_condicao_verdadeira: bool = false
var executar_se_condicao_falsa: bool = false

# Enum dos tipos de comando
enum TipoComando {
	MOVER_PARA_FRENTE,
	VIRAR,
	PEGAR,
	LARGAR
}

var direcao : Vector2

#Condição em que uma ação será executada
enum Condicao {
	NENHUMA,
	OBSTACULO_A_FRENTE
}

func _init(_nome: String = "", _tipo: int = TipoComando.MOVER_PARA_FRENTE, _textura: Texture2D = null, _condicao: Condicao = Condicao.NENHUMA, _repetir: int = 1):
	nome = _nome
	tipo = _tipo
	textura = _textura
	condicao = _condicao
	repetir = _repetir

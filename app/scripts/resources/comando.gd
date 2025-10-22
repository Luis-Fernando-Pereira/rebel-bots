extends Resource
class_name Comando

# Permite exportar no editor
@export var _nome: String

var nome: String:
	get:
		return _nome
	set(valor):
		_nome = valor

@export var _tipo: TipoComando = TipoComando.MOVER_PARA_FRENTE
var tipo: TipoComando:
	get:
		return _tipo
	set(valor):
		_tipo = valor 

@export var _textura: Texture2D

var textura: Texture2D:
	get:
		return _textura
	set(valor):
		_textura = valor

# Condição opcional (pode ser script ou string para simplificação)
@export var _condicao: Condicao
var condicao: Condicao:
	get:
		return _condicao
	set(valor):
		_condicao = valor

# Laço de repetição opcional
@export var _repetir: int = 1  # 1 = executar uma vez
var repetir: int:
	get:
		return _repetir
	set(valor):
		_repetir = valor

@export var _direcao: Global.Direcoes 
var direcao: Global.Direcoes:
	get:
		return _direcao
	set(valor):
		if valor != null:
			_direcao = valor
		else:
			_direcao = Global.Direcoes.DIREITA 


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

#Condição em que uma ação será executada
enum Condicao {
	NENHUMA,
	OBSTACULO_A_FRENTE
}

func _init(_nome_comando: String = "", _tipo_comando: TipoComando = TipoComando.MOVER_PARA_FRENTE, _textura_comando: Texture2D = null, _condicao_comando: Condicao = Condicao.NENHUMA, _repetir_comando: int = 1):
	nome = _nome_comando
	tipo = _tipo_comando
	textura = _textura_comando
	condicao = _condicao_comando
	repetir = _repetir_comando


func duplicar() -> Comando:
	var novo = Comando.new(
		_nome,
		_tipo,
		_textura,
		_condicao,
		_repetir
	)
	novo.direcao = self.direcao
	novo.obstaculo_a_frente = self.obstaculo_a_frente
	novo.executar_se_condicao_verdadeira = self.executar_se_condicao_verdadeira
	novo.executar_se_condicao_falsa = self.executar_se_condicao_falsa
	return novo

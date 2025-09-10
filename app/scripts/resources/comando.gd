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

# Enum dos tipos de comando
enum TipoComando {
	MOVER_PARA_FRENTE,
	VIRAR,
	PEGAR,
	LARGAR
}


#Condição em que uma ação será executada
enum Condicao {
	NENHUMA #Sempre irá executar a ação
}

func _init(_nome: String = "", _tipo: int = TipoComando.MOVER_PARA_FRENTE, _textura: Texture2D = null, _condicao: Condicao = Condicao.NENHUMA, _repetir: int = 1):
	nome = _nome
	tipo = _tipo
	textura = _textura
	condicao = _condicao
	repetir = _repetir

# Método para execução do comando (pode ser chamado pelo personagem)
func executar():
	for i in range(repetir):
		if condicao_válida():
			match tipo:
				TipoComando.MOVER_PARA_FRENTE:
					mover_frente()
				TipoComando.VIRAR:
					virar()
				TipoComando.PEGAR:
					pegar()
				TipoComando.LARGAR:
					largar()

# Checa se a condição é válida
func condicao_válida() -> bool:
	if condicao == Condicao.NENHUMA:
		return true
	# Aqui você pode implementar lógica real
	# Ex: checar variável do personagem ou do mundo
	return true

# Funções de ação (substitua com lógica real)
func mover_frente():
	print("Movendo para frente") 

func virar():
	print("Virando")

func pegar():
	print("Pegando objeto")

func largar():
	print("Largando objeto")

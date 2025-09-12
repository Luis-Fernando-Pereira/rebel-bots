extends Resource

class_name Instrucao

var em_execucao: bool
var comando: Comando

func nova_instrucao(comando: Comando, em_execucao = false) -> Instrucao:
	var instrucao = Instrucao.new()
	instrucao.em_execucao = em_execucao
	instrucao.comando = comando
	
	return instrucao

extends Resource

class_name Instrucao

var em_execucao: bool
var comando: Comando

func nova_instrucao(_comando: Comando, _em_execucao = false) -> Instrucao:
	var instrucao = Instrucao.new()
	instrucao.em_execucao = _em_execucao
	instrucao.comando = _comando
	
	return instrucao

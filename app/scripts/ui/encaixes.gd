extends Control

signal lista_de_comandos_alterado(lista_de_comandos)

var lista_de_comandos: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lista_de_comandos.resize(9)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_encaixe_comando_encaixado(encaixe: int, comando: Comando) -> void:
	alterar_lista_de_encaixe(encaixe, comando)


func _on_encaixe_2_comando_encaixado(encaixe: int, comando: Comando) -> void:
	alterar_lista_de_encaixe(encaixe, comando)


func _on_encaixe_3_comando_encaixado(encaixe: int, comando: Comando) -> void:
	alterar_lista_de_encaixe(encaixe, comando)


func _on_encaixe_4_comando_encaixado(encaixe: int, comando: Comando) -> void:
	alterar_lista_de_encaixe(encaixe, comando)


func _on_encaixe_5_comando_encaixado(encaixe: int, comando: Comando) -> void:
	alterar_lista_de_encaixe(encaixe, comando)


func _on_encaixe_6_comando_encaixado(encaixe: int, comando: Comando) -> void:
	alterar_lista_de_encaixe(encaixe, comando)


func _on_encaixe_7_comando_encaixado(encaixe: int, comando: Comando) -> void:
	alterar_lista_de_encaixe(encaixe, comando)
	

func alterar_lista_de_encaixe(encaixe: int, comando: Comando) -> void:
	var comando_no_encaixe = lista_de_comandos.get(encaixe)
	if comando_no_encaixe == null:
		lista_de_comandos.insert(encaixe,comando)
	else:
		print("Já existe um comando neste encaixe!")
	

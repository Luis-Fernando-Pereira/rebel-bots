extends Control

signal lista_de_comandos_alterado(lista_de_comandos)

var lista_de_comandos: Array
var z_index_original: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index_original = z_index
	lista_de_comandos.resize(9)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
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
	lista_de_comandos.insert(encaixe, comando)
	lista_de_comandos_alterado.emit(lista_de_comandos)


func _on_button_pressed() -> void:
	visible = false
	z_index = z_index_original
	Global.play = true

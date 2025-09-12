extends Control

signal comando_encaixado(encaixe: int, comando: Comando)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_encaixe_comando_encaixado(encaixe: int, comando: Comando) -> void:
	comando_encaixado.emit(encaixe, comando)

func _on_encaixe_2_comando_encaixado(encaixe: int, comando: Comando) -> void:
	comando_encaixado.emit(encaixe, comando)

func _on_encaixe_3_comando_encaixado(encaixe: int, comando: Comando) -> void:
	comando_encaixado.emit(encaixe, comando)

func _on_encaixe_4_comando_encaixado(encaixe: int, comando: Comando) -> void:
	comando_encaixado.emit(encaixe, comando)

func _on_encaixe_5_comando_encaixado(encaixe: int, comando: Comando) -> void:
	comando_encaixado.emit(encaixe, comando)

func _on_encaixe_6_comando_encaixado(encaixe: int, comando: Comando) -> void:
	comando_encaixado.emit(encaixe, comando)

func _on_encaixe_7_comando_encaixado(encaixe: int, comando: Comando) -> void:
	comando_encaixado.emit(encaixe, comando)

func _on_encaixe_8_comando_encaixado(encaixe: int, comando: Comando) -> void:
	comando_encaixado.emit(encaixe, comando)

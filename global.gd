extends Node

#Vector2(1, 0) → indo totalmente para a direita
#Vector2(-1, 0) → indo totalmente para a esquerda
#Vector2(0, -1) → indo totalmente para cima
#Vector2(0, 1) → indo totalmente para baixo

var esta_arrastando = false
enum Comandos{MOVER_PARA_FRENTE,VIRAR}
const unidade_de_movimento = 124
var play = false
var jogo_terminou = false
var nivel_vencido = false

var mostrar_tutorial1 = true
var mostrar_tutorial2 = true
var mostrar_tutorial3 = true

#///*, "nivel03.tscn"*/

var niveis = ["nivel01.tscn", "nivel01_01.tscn", "nivel02.tscn"]
var nivel_atual = null
var proximo_nivel = niveis[0]
var nivel_anterior = null
var creditos = false

enum Estado {IDLE, EXECUTANDO, FINALIZADO}

enum Direcoes{ESQUERDA, DIREITA, CIMA, BAIXO}

const direita := Vector2.RIGHT
const esquerda = Vector2.LEFT
const cima = Vector2.UP
const baixo = Vector2.DOWN
const parar = Vector2.ZERO

func resetar_variaveis_globais():
	Global.jogo_terminou = false
	Global.play = false
	Global.nivel_vencido = false

func ir_para_nivel_anterior(tree: SceneTree):
	tree.change_scene_to_file("res://app/scenes/levels/"+Global.nivel_anterior)

func resetar_todos_os_niveis(tree: SceneTree):
	Global.nivel_atual = null
	Global.proximo_nivel = Global.niveis[0]
	Global.nivel_anterior = null
	Global.creditos = false
	tree.change_scene_to_file("res://app/scenes/ui/title_screen.tscn")


func ir_para_proximo_nivel(tree: SceneTree):
	var proximo_indice = Global.niveis.find(Global.proximo_nivel)
	
	if Global.proximo_nivel == null:
		tree.change_scene_to_file("res://app/scenes/levels/vitoria.tscn")
		return
	
	Global.nivel_anterior = Global.nivel_atual
	Global.nivel_atual = Global.proximo_nivel
	if Global.niveis.size() > proximo_indice + 1:
		Global.proximo_nivel = Global.niveis[proximo_indice + 1]
	else:
		Global.proximo_nivel = null
	
	print("Anterior:", Global.nivel_anterior)
	print("Atual:", Global.nivel_atual)
	print("Próximo:", Global.proximo_nivel)
	
	tree.change_scene_to_file("res://app/scenes/levels/" + Global.nivel_atual)

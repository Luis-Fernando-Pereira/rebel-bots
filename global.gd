extends Node

#Vector2(1, 0) → indo totalmente para a direita
#Vector2(-1, 0) → indo totalmente para a esquerda
#Vector2(0, -1) → indo totalmente para cima
#Vector2(0, 1) → indo totalmente para baixo

var esta_arrastando = false
enum Comandos{MOVER_PARA_FRENTE,VIRAR}
const unidade_de_movimento = 50
var play = false

enum Estado {IDLE, EXECUTANDO, FINALIZADO}

enum Direcoes{ESQUERDA, DIREITA, CIMA, BAIXO}

const direita := Vector2.RIGHT
const esquerda = Vector2.LEFT
const cima = Vector2.UP
const baixo = Vector2.DOWN

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func esconder_virar_esquerda():
	$VirarEsquerda.visible = false;

func mostrar_virar_esquerda():
	$VirarEsquerda.visible = true;

func esconder_virar_direita():
	$VirarDireita.visible = false;

func mostrar_virar_direita():
	$VirarDireita.visible = true;

func esconder_virar_cima():
	$VirarCima.visible = false;

func mostrar_virar_cima():
	$VirarCima.visible = true;

func esconder_virar_baixo():
	$VirarBaixo.visible = false;

func mostrar_virar_baixo():
	$VirarBaixo.visible = true;

func tam_color_rect_64():
	$ColorRect.size.x = 64;

func tam_color_rect_112():
	$ColorRect.size.x = 64;

func tam_color_rect_160():
	$ColorRect.size.x = 160;

func tam_color_rect_208():
	$ColorRect.size.x = 208;

func tam_color_rect_256():
	$ColorRect.size.x = 256;

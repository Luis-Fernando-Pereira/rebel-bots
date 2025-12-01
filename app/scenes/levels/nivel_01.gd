extends Node2D

@export var robo: Area2D
@export var tela_game_over: CanvasLayer
@export var area_vitoria: Area2D
@export var proxima_fase: String

func _ready():
	$Esteira1/AnimatedSprite2D.play()
	$Esteira1/AnimatedSprite2D2.play()
	$Esteira2/AnimatedSprite2D.play()
	$Esteira2/AnimatedSprite2D2.play()
	$Esteira2/AnimatedSprite2D3.play()
	$Esteira3/AnimatedSprite2D.play()
	$Esteira3/AnimatedSprite2D2.play()
	$Esteira3/AnimatedSprite2D3.play()
	
	$HudButtons.visible = true
	
	$Comandos.esconder_virar_baixo()
	$Comandos.esconder_virar_cima()
	$Comandos.esconder_virar_direita()
	$Comandos.esconder_virar_esquerda()
	
	$Comandos.tam_color_rect_64()
	

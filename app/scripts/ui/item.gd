extends Node2D

signal comando_emitido(comando:Comando)

@export var comando :Comando

var arrastavel = false
var esta_dentro_de_largavel = false
var ref_de_corpo
var offset: Vector2
var pos_inicial: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if comando.sprite:
		$Sprite2D.texture = comando.sprite

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:	
	if arrastavel:
		if Input.is_action_just_pressed("click"):
			offset = get_global_mouse_position() - global_position
			Global.esta_arrastando = true
		 
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		
		elif Input.is_action_just_released("click"):
			Global.esta_arrastando = false
			var tween = get_tree().create_tween()
			
			if esta_dentro_de_largavel:
				comando_emitido.emit(comando)
				
				tween.tween_property(self, "position", ref_de_corpo.position, 0.2).set_ease(Tween.EASE_OUT)
				
			else:
				tween.tween_property(self, "global_position", pos_inicial, 0.2).set_ease(Tween.EASE_OUT)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('dropable'):
		esta_dentro_de_largavel = true
		body.modulate = Color(Color.REBECCA_PURPLE, 1)
		ref_de_corpo = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group('dropable'):
		esta_dentro_de_largavel = false
		body.modulate = Color(Color.MEDIUM_PURPLE, 0.7)

func _on_area_2d_mouse_entered() -> void:
	if not Global.esta_arrastando:
		arrastavel = true
		scale = Vector2(1.05, 1.05)

func _on_area_2d_mouse_exited() -> void:
	if not Global.esta_arrastando:
		arrastavel = false
		scale = Vector2(1,1)

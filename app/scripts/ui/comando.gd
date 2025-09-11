extends Node2D

@export var comando: Comando

signal comando_encaixado(comando: Comando)

var arrastavel = false
var deslocamento: Vector2
var pos_nicial: Vector2
var esta_dentro_de_soltavel = false
var ref_corpo: Node2D
var corpos_dentro = []
var z_index_original = z_index

func _ready():
	if comando != null: 
		if comando.textura:
			$Sprite2D.texture = comando.textura

func _process(_delta):
	if arrastavel:
		if Input.is_action_just_pressed("click"):
			pos_nicial = global_position
			deslocamento = get_global_mouse_position() - global_position
			Global.esta_arrastando = true
			
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position()
			
		elif Input.is_action_just_released("click"):
			Global.esta_arrastando = false
			
			position = pos_nicial
			
			if esta_dentro_de_soltavel:
				encaixar_comando()

func encaixar_comando():
	comando_encaixado.emit(comando)

func _on_area_2d_mouse_entered() -> void:
	if not Global.esta_arrastando:
		arrastavel = true
		scale = Vector2(1.05, 1.05)
		z_index = 4

func _on_area_2d_mouse_exited() -> void:
	if not Global.esta_arrastando:
		arrastavel = false
		scale = Vector2(1,1)
		self.z_index = z_index_original

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body not in corpos_dentro:
		corpos_dentro.append(body)
	
	if body.is_in_group('soltavel'):
		esta_dentro_de_soltavel = true
		body.modulate = Color(Color.REBECCA_PURPLE,1)
		ref_corpo = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body in corpos_dentro:
		corpos_dentro.erase(body)
	
	if body.is_in_group('soltavel'):
		esta_dentro_de_soltavel = false
		body.modulate = Color(Color.MEDIUM_PURPLE, 0.7)

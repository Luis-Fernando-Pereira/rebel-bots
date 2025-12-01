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
var mouse_sobre_ui = false
var clicou_pos: Vector2
var arrastando = false

func _ready():
	$Control.z_index = 3
	if comando != null: 
		if comando.nome:
			$Control/Titulo.text = comando.nome
		
		if comando.textura:
			$Sprite2D.texture = comando.textura

func _process(_delta):
	
	if arrastavel:
		
		if Input.is_action_just_pressed("click"):
			pos_nicial = global_position   # salva em coordenadas globais
			clicou_pos = get_global_mouse_position()
			deslocamento = clicou_pos - global_position
			Global.esta_arrastando = true
			arrastando = false
			
		if Input.is_action_pressed("click") and Global.esta_arrastando:
			var dist = clicou_pos.distance_to(get_global_mouse_position())
			if dist > 5:
				arrastando = true
				global_position = get_global_mouse_position() - deslocamento
				
		elif Input.is_action_just_released("click") and Global.esta_arrastando:
			Global.esta_arrastando = false
			
			if arrastando:
				global_position = pos_nicial   # <<< aqui era o erro
				if esta_dentro_de_soltavel:
					encaixar_comando()
			else:
				alternar_ui()
				
			arrastavel = false

func encaixar_comando():
	comando_encaixado.emit(comando.duplicar())

func _on_area_2d_mouse_entered() -> void:
	$HoverSound.play()
	if not Global.esta_arrastando:
		arrastavel = true
		scale = Vector2(1.05, 1.05)
		z_index = 2

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

func alternar_ui() -> void:
	$Control.visible = !$Control.visible
	
	if comando.tipo == Comando.TipoComando.MOVER_PARA_FRENTE:
		$Control/SpinBox.visible = true
		$Control/InputLabel.visible = true
	else:
		$Control/SpinBox.visible = false
		$Control/InputLabel.visible = false

func _on_spin_box_focus_exited() -> void:
	if $Control/SpinBox.value != null && $Control/SpinBox.value != 0:
		if comando != null:
			comando.repetir = $Control/SpinBox.value

func _on_spin_box_value_changed(value: float) -> void:
	if $Control/SpinBox.value != null && $Control/SpinBox.value != 0:
		if comando != null:
			comando.repetir = $Control/SpinBox.value

func _on_control_mouse_entered() -> void:
	arrastavel = false

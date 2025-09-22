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
	if comando != null: 
		if comando.textura:
			$Sprite2D.texture = comando.textura

func _process(_delta):
	if arrastavel:
		if Input.is_action_just_pressed("click"):
			pos_nicial = global_position
			clicou_pos = get_global_mouse_position()
			deslocamento = clicou_pos - global_position
			arrastando = false
			Global.esta_arrastando = false

		if Input.is_action_pressed("click"):
			var dist = clicou_pos.distance_to(get_global_mouse_position())
			if dist > 5:
				arrastando = true
				Global.esta_arrastando = true
				global_position = get_global_mouse_position() - deslocamento
		elif Input.is_action_just_released("click"):
			if arrastando:
				position = pos_nicial
				if esta_dentro_de_soltavel:
					encaixar_comando()
				arrastando = false
				Global.esta_arrastando = false
			else:
				alternar_ui()


func encaixar_comando():
	comando_encaixado.emit(comando)

func _on_area_2d_mouse_entered() -> void:
	if not arrastando:
		arrastavel = true
		scale = Vector2(1.05, 1.05)
		z_index = 4

func _on_area_2d_mouse_exited() -> void:
	if not arrastando:
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
	if comando.tipo == Comando.TipoComando.MOVER_PARA_FRENTE:
		$Control.visible = !$Control.visible

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

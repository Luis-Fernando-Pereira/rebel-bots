extends StaticBody2D

signal comando_encaixado(encaixe: int, comando: Comando)

@export var encaixe :int
var comando: Comando
var comando_temp: Comando

func _ready() -> void:
	modulate = Color(Color.MEDIUM_PURPLE, 0.7)

func _process(_delta: float) -> void:
	if Global.esta_arrastando:
		visible = true
	else:
		visible = false
		
	if Input.is_action_just_released("click") && comando_temp != null:
		comando = comando_temp
		comando_temp = null
		comando_encaixado.emit(encaixe, comando)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if  area.is_in_group("comando") && area.get_parent().comando != null:
		comando_temp = area.get_parent().comando

extends Control

func _ready() -> void:
	if !Global.mostrar_tutorial3:
		hide()

func _on_comecar_pressed() -> void:
	Global.mostrar_tutorial3 = false
	hide()

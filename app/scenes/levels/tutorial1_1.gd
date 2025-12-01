extends Control

func _ready() -> void:
	if !Global.mostrar_tutorial2:
		hide()
		$Video1.stop()
	$Video1.volume = 0

func _on_comecar_pressed() -> void:
	Global.mostrar_tutorial2 = false
	$Video1.stop()
	hide()

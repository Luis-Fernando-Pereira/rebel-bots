extends Control

func _ready() -> void:
	if !Global.mostrar_tutorial1:
		hide()
		$Video1.stop()
	$Video1.volume = 0
	$Video2.volume = 0
	$Video3.volume = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_proximo_pressed() -> void:
	$Video1.stop()
	$Video1.hide()
	$TextoTutorial1.hide()
	$Proximo.hide()
	$TextoTutorial2.show()
	$Video2.show()
	$Video2.play()
	$Proximo2.show()


func _on_comecar_pressed() -> void:
	Global.mostrar_tutorial1 = false
	$Video3.stop()
	hide()


func _on_proximo_2_pressed() -> void:
	$TextoTutorial2.hide()
	$Video2.hide()
	$Video2.stop()
	$Proximo2.hide()
	$TextoTutorial3.show()
	$Comecar.show()
	$Video3.show()
	$Video3.play()

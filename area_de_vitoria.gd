extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("vitoria"):
		$VitoriaSound.play()
		Global.nivel_vencido = true

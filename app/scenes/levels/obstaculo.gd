extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("colidivel"): 
		Global.play = false
		Global.jogo_terminou = true

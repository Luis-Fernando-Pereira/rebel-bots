extends Node2D


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("colidivel"): 
		$LossSound.play()
		$Impacto.play(0.85)
		Global.play = false
		Global.jogo_terminou = true


func _on_timer_timeout() -> void:
	pass

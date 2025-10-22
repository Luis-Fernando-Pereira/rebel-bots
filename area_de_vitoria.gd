extends Area2D

signal vitoria_alcancada

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("colidivel"): 
		emit_signal("vitoria_alcancada")

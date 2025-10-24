extends Area2D

signal vitoria_alcancada

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("vitoria"): 
		get_tree().change_scene_to_file("res://app/scenes/levels/nivel02.tscn")
		Global.nivel_vencido = true
		if Global.nivel_atual == null:
			get_tree().change_scene_to_file("res://app/scenes/ui/vitoria.tscn")

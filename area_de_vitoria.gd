extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("vitoria"): 
		get_tree().change_scene_to_file("res://app/scenes/levels/nivel02.tscn")

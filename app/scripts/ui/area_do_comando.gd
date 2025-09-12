extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group('soltavel'):
		esta_dentro_de_soltavel = true
		area.modulate = Color (Color.REBECCA_PURPLE,1)
		ref_corpo = area


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group('soltavel'):
		esta_dentro_de_soltavel = false
		area.modulate = Color(Color.MEDIUM_PURPLE, 0.7)

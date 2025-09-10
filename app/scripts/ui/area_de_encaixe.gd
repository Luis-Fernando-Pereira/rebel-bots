extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(_delta: float) -> void:
	if Global.esta_arrastando:
		visible = true
	else: 
		visible = true
		if Input.is_action_just_released("click"):
			pass
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("comando"):
		print("area detectado, encaixe: ")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("comando"):
		print("corpo detectado, encaixe: ")

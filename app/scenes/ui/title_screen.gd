extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_start_btn_pressed() -> void:
	$StartSound.play()
	
	if $Timer.timeout:
		Global.ir_para_proximo_nivel(get_tree())


func _on_credits_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://app/scenes/levels/creditos.tscn")


func _on_quit_btn_pressed() -> void:
	get_tree().quit()


func _on_start_btn_mouse_entered() -> void:
	playHoverSound()


func _on_quit_btn_mouse_entered() -> void:
	playHoverSound()


func _on_credits_btn_mouse_entered() -> void:
	playHoverSound()


func _on_link_btn_mouse_entered() -> void:
	playHoverSound()


func playHoverSound():
	$HoverSound.play()

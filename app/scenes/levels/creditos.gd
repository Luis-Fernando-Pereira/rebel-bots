extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.creditos = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	$HUD.visible = true


func _on_audio_stream_player_2d_finished() -> void:
	$AudioStreamPlayer2D.play()

extends Node2D

var play: bool = true

func _process(_delta: float) -> void:
	if not $AudioStreamPlayer.playing and play:
		$AudioStreamPlayer.play()


func ToggleMusic() -> void:
	play = !play
	$AudioStreamPlayer.playing = play

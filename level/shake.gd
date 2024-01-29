extends Camera2D

@export var noise: Noise

var noise_strength: float = 0.0
var time: float = 0.0

func _process(delta: float) -> void:
	time += delta
	if noise_strength <= 0:
		position = Vector2.ZERO
		noise_strength = 0
	else:
		noise_strength -= delta
		position.x = noise.get_noise_2d(time, 10) * 270 * noise_strength;
		position.y = noise.get_noise_2d(10, time) * 270 * noise_strength;

func Shake(strength: float) -> void:
	noise_strength += strength

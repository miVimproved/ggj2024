extends Area2D

class_name Potion

signal Killed

const fallSpeed: float = 0.7

var potionData: GameData.PotionData
var canPickup: bool = true

var currentPoint: Area2D
var nextPoint: Area2D
var cam: Camera2D

func Setup(data: GameData.PotionData, _cam: Camera2D) -> void:
	cam = _cam
	potionData = data
	$sprite.modulate = GameData.ColorCodes[data.color]
	$CPUParticles2D.modulate = GameData.ColorCodes[data.color]
	$CPUParticles2D2.modulate = GameData.ColorCodes[data.color]
	$CPUParticles2D3.modulate = GameData.ColorCodes[data.color]
	$sprite/Temp.frame = data.shape
	$sprite/AnimatedSprite2D.animation = str(data.shape)
	$sprite/AnimatedSprite2D.play()
	currentPoint = get_parent()
	nextPoint = get_parent()
	$sprite/AnimatedSprite2D.speed_scale = randf_range(0.8, 1.2)

var knocked: bool = false
func Knock() -> void:
	knocked = true
	create_tween().tween_property(self, "position", Vector2(position.x, 800), fallSpeed).set_trans(Tween.TRANS_QUAD)
	create_tween().tween_property($sprite, "rotation_degrees", randf_range(-500, 500), fallSpeed)
	await get_tree().create_timer(fallSpeed * 3 / 4).timeout
	$CPUParticles2D.emitting = true
	$CPUParticles2D2.emitting = true
	$CPUParticles2D3.emitting = true
	await get_tree().create_timer(fallSpeed * 1 / 4).timeout
	cam.Shake(0.5)
	$AudioStreamPlayer2D.play()
	emit_signal("Killed")

func Entered(area) -> void:
	if area.is_in_group("spawn") and (area.get_child_count() < 3 or area == get_parent()):
		nextPoint = area

func Exited(area):
	if area == nextPoint:
		nextPoint = null

func Place() -> void:
	z_index = 2
	if nextPoint and nextPoint != currentPoint:
		currentPoint.call_deferred("remove_child", self)
		nextPoint.call_deferred("add_child", self)
		currentPoint = nextPoint
		set_deferred("position", Vector2.ZERO)
	else:
		create_tween().tween_property(self, "global_position", currentPoint.global_position, 0.1)
	create_tween().tween_property(self, "rotation", 0, 0.1)

func Start() -> void:
	canPickup = false


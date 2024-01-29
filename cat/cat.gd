extends Area2D

class_name Cat

signal Finished

var direction: int = 1

var speed: float = 200
var lowThink: float = 1.0
var highThink: float = 4.0

var going: int = 0

var catData: GameData.CatData

var ranInto: int = 0

var effectiveColor: GameData.Colors
var effectiveSpots: GameData.Colors

var done: bool = false

func _process(delta: float) -> void:
	position.x += speed * delta * going * direction
	if (global_position.x > 1380 or global_position.x < -100) and not done:
		done = true
		emit_signal("Finished")

func Start() -> void:
	going = 1
	PlayAnimations("walking")

func Setup(data: GameData.CatData) -> void:
	catData = data
	direction = 1 if data.isRight else -1
	for animator: AnimatedSprite2D in $Node2D.get_children(): animator.flip_h = data.isRight
	$Node2D/cat.modulate = GameData.ColorCodes[data.color]
	$Node2D/socks.modulate = Color.WHITE if data.hasSocks else GameData.ColorCodes[data.color]
	$Node2D/spot.modulate = GameData.ColorCodes[data.spotColor] * 0.8
	$Node2D/spot3.visible = data.moreWhiskers
	PlayAnimations("sitting")
	effectiveColor = data.color
	effectiveSpots = data.spotColor
	if data.moreWhiskers:
		effectiveColor = data.spotColor
		effectiveSpots = data.color


func AreaCollision(area):
	if not area is Potion: return
	if going == 0: return
	var potion: Potion = area
	if potion.knocked:
		going = 0
		PlayAnimations("sitting")
		$Node2D/cat.play("ow")
		await get_tree().create_timer(1.5).timeout
		PlayAnimations("walking")
		going = 1
		return
	
	going = 0
	PlayAnimations("bop")
	await get_tree().create_timer(randf_range(lowThink, highThink)).timeout
	
	var fall: bool = false

#SPOT COLOR:
#[Orange, Gray,     Purple] spots will treat
#[circle, triangle, square] potions as
#[Orange, Gray,     Purple] potions, regardless of what color they actually are 
#
#Orange - Circle
#Gray   - Triangle 
#Purple - Square
	var effectivePColor: GameData.Colors = potion.potionData.color
	if potion.potionData.shape == catData.spotColor:
		#print("SAME SPOT COLOR")
		effectivePColor = catData.spotColor

#COLOR: A cat will only knock down a potion of its same color.
#BUT, if it encounters a potion of a different color first, it will knock it down.
#SOCKS: A cat with socks will knock down a potion not of its color if that potion is the third potion it encounters

	var isOdd: bool = ranInto % 2
	if catData.hasSocks: isOdd = !isOdd
	#var isOdd: bool = catData.hasSocks

	if isOdd:
		fall = effectiveColor == effectivePColor
	else:
		fall = effectiveColor != effectivePColor

	if fall:
		potion.Knock();
		PlayAnimations("sitting")
		#catData.color = potion.potionData.color
		#Setup(catData)
		await get_tree().create_timer(0.5).timeout
	PlayAnimations("walking")
	ranInto += 1
	going = 1

func PlayAnimations(animation: String) -> void:
	for animator: AnimatedSprite2D in $Node2D.get_children():
		animator.play(animation)

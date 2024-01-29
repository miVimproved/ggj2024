extends Area2D

var hovered: Potion
var hovering: bool = false
var left: bool = false

func _input(event: InputEvent):
	if event is InputEventMouse:
		position = get_viewport().get_mouse_position()

func _process(delta: float):
	if Input.is_action_pressed("click") and not Input.is_action_just_pressed("click") and hovered and not hovering and hovered.canPickup:
		hovering = true
		for child: Area2D in get_tree().get_nodes_in_group("spawn"):
			if child.get_child_count() == 2 or child == hovered.get_parent():
				child.get_child(0).show()
	if Input.is_action_pressed("click") and hovering and hovered and hovered.canPickup:
		var nextPos: Vector2 = global_position
		var currentPos: Vector2 = hovered.global_position
		if hovered.nextPoint: nextPos = (hovered.nextPoint.global_position + position) / 2
		hovered.global_position = hovered.global_position.lerp(nextPos, delta * 20)
		var change: Vector2 = hovered.global_position - currentPos
		#hovered.rotation_degrees = lerpf(hovered.rotation_degrees, change.x, delta * 2);
		hovered.rotation_degrees = change.x
		hovered.z_index = 3
		hovering = true
	if (Input.is_action_just_released("click") and hovered and hovered.canPickup) or (hovering and not hovered.canPickup):
		for child: Area2D in get_tree().get_nodes_in_group("spawn"):
			child.get_child(0).hide()
		hovered.Place()
		hovering = false
		if left:
			hovered = null

func Entered(area) -> void:
	if area is Potion and not hovering:
		hovered = area


func Exited(area) -> void:
	if not hovering:
		if area == hovered:
			hovered = null
	else:
		left = true

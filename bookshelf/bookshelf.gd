extends Area2D


func _ready() -> void:
	var anims: AnimatedSprite2D = $Books
	#anims.play(anims.sprite_frames.animations.pick_random().name)
	anims.frame = randi_range(0, anims.sprite_frames.get_frame_count(anims.animation) - 1)
	position.x = randf_range(-30, 30)
	position.y = randf_range(-10, 10)

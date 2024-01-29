extends Control

const levelsPerPage: int = Global.amountPerLevel

func _ready() -> void:
	$VBoxContainer/MarginContainer2/HBoxContainer/HSlider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	$VBoxContainer/MarginContainer2/HBoxContainer/HSlider2.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	for i: int in range(GameData.new().Levels.size()):
		var button: Button = Button.new()
		var scene: int = floori(float(i) / levelsPerPage)
		button.disabled = i > Global.levelsComplete
		button.text = "Level " + str(scene) + "-" + str(i % levelsPerPage)
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.size_flags_vertical = Control.SIZE_EXPAND_FILL
		$VBoxContainer/MarginContainer/VBoxContainer.get_child(scene).add_child(button)
		button.pressed.connect(GoToLevel.bind(i))

func GoToLevel(level: int) -> void:
	Global.currentLevel = level
	get_tree().change_scene_to_file("res://level/levelScene.tscn")

func SetSFXVolume(volume: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(volume))

func SetMusicVolume(volume: float) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(volume))


func fullscreen():
	var newMode: DisplayServer.WindowMode = DisplayServer.WINDOW_MODE_FULLSCREEN
	if DisplayServer.window_get_mode(0) == newMode:
		newMode = DisplayServer.WINDOW_MODE_WINDOWED
	DisplayServer.window_set_mode(newMode)

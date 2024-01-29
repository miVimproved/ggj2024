extends Control

@export var cam: Camera2D
@export var desc: Label

var CatSpawn: PackedScene = preload("res://cat/cat.tscn")
var PotionSpawn: PackedScene = preload("res://potion/potion.tscn")
var BookshelfSpawn: PackedScene = preload("res://bookshelf/bookshelf.tscn")

var spawns: Array[Node]

var cats: Array[Cat]
var potions: Array[Potion]
var level: int = 0

func _ready() -> void:
	var ii: int = Global.currentLevel
	var scene: int = floori(float(ii) / Global.amountPerLevel)
	$CanvasLayer/hudelements/level.text = "Level " + str(scene) + "-" + str(ii % Global.amountPerLevel)
	spawns = get_tree().get_nodes_in_group("spawn")
	var levelData: Array = GameData.new().Levels[Global.currentLevel]
	if levelData.size() == 13:
		desc.text = levelData[12]
	else:
		desc.text = GameData.GenLST()
	desc.visible_ratio = 0
	create_tween().tween_property(desc, "visible_ratio", 1.0, 3.0);
	for i in range(12):
		var object: GameData.GameObject = levelData[i]
		
		if object is GameData.CatData:
			var toAdd: Cat = CatSpawn.instantiate()
			spawns[i].add_child(toAdd)
			cats.append(toAdd)
			toAdd.Setup(object)
			toAdd.Finished.connect(CatFinished.bind(toAdd))
			

		elif object is GameData.PotionData:
			var toAdd: Potion = PotionSpawn.instantiate()
			spawns[i].add_child(toAdd)
			potions.append(toAdd)
			toAdd.Setup(object, cam)
			toAdd.Killed.connect(KilledPotion.bind(toAdd))
			

		elif object is GameData.BookshelfObject:
			var toAdd: Area2D = BookshelfSpawn.instantiate()
			spawns[i].add_child(toAdd)

		elif object is GameData.DummyObject:
			pass

func KilledPotion(potion: Potion) -> void:
	potions.erase(potion)
	if potions.size(): return
	
	await get_tree().create_timer(1.0).timeout
	var winScreen: Panel = $CanvasLayer/hudelements/win
	create_tween().tween_property(winScreen, "position", Vector2.ZERO, 1.0).set_trans(Tween.TRANS_SINE)

func CatFinished(cat: Cat) -> void:
	cats.erase(cat)
	if cats.size(): return
	if not potions.size(): return
	
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()

var going: bool = false
func SendCats() -> void:
	if going: return
	going = true
	for cat: Cat in cats: cat.Start()
	for potion: Potion in potions: potion.Start()
	$CanvasLayer/hudelements/buttons/sendcat.hide()


func _on_sendcat_2_pressed() -> void:
	get_tree().reload_current_scene()


func menu() -> void:
	get_tree().change_scene_to_file("res://menu/levelselect.tscn")


func next():
	Global.currentLevel += 1
	Global.levelsComplete = max(Global.levelsComplete, Global.currentLevel)
	var ii: int = Global.currentLevel
	if ii > GameData.new().Levels.size() - 1:
		get_tree().change_scene_to_file("res://menu/levelselect.tscn")
	else:
		get_tree().reload_current_scene()

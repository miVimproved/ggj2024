extends Node

class_name GameData

enum Colors {
	Orange,
	Gray,
	Purple,

	Max
}

const ColorCodes: Array[Color] = [
	Color.ORANGE,
	Color.GRAY,
	Color.PURPLE,

	Color.RED
]

class GameObject extends RefCounted:
	var color: Colors

class DummyObject extends GameObject:
	pass


class BookshelfObject extends GameObject:
	pass

class CatData extends GameObject:
	var spotColor: Colors
	var isSpotLeft: bool
	var moreWhiskers: bool
	var hasSocks: bool
	var isRight: bool
	
	static func Create(_color: Colors, _spotColor: Colors, _whiskerCount: bool, _hasSocks: bool, _right: bool) -> CatData:
		var toReturn: CatData = CatData.new()
		
		toReturn.color = _color
		toReturn.spotColor = _spotColor
		toReturn.moreWhiskers = _whiskerCount
		toReturn.hasSocks = _hasSocks
		toReturn.isRight = _right
		
		return toReturn

class PotionData extends GameObject:
	enum Shapes {
		Circle_Orange,
		Triangle_Gray,
		Square_Purple,
		
		Max
	}
	var shape: Shapes
	
	static func Create(_color: Colors, _shape: Shapes = Shapes.Max) -> PotionData:
		var toReturn: PotionData = PotionData.new()
		
		toReturn.color = _color
		toReturn.shape = _shape
		
		if toReturn.shape == Shapes.Max:
			toReturn.shape = _color as Shapes
		
		return toReturn


static func GenLST() -> String:
	return LoadingScreenTips.pick_random()

const LoadingScreenTips: Array[String] = [
	"I am a distraction! Don't pay attention to me!",
	"Oh my gosh! That box over there is such a good size!",
	"I repeat: A thousand-fold!",
	"Aboogeywoogeywoo!",
	"Meow meow meow meow-meow. Meow meeoow, meow Meow meowing Meow. Meow!",
	"Allan please add tip.",
	"Sorry, there's a cat on my lap. I won't be able to get up for the next few hours.",
	"MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW ",
	"Woof!"
]

# Type, Color, other
# Spot Color, Whiskers, Socks

var Levels: Array[Array] = [
	[ # 0-0
		PotionData.Create(Colors.Purple),
		BookshelfObject.new(),
		BookshelfObject.new(),
		BookshelfObject.new(),
		
		DummyObject.new(),
		DummyObject.new(),
		DummyObject.new(),
		CatData.Create(Colors.Orange, Colors.Orange, false, false, false),
		
		BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(),
		"The goal of the game is probably to drag the potions so that the cats knock down every single one."
	],
	[ # 0-1
		BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(),
		
		DummyObject.new(),
		PotionData.Create(Colors.Purple),
		PotionData.Create(Colors.Orange),
		CatData.Create(Colors.Orange, Colors.Orange, false, false, false),
		
		BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(),
		"I think that when cats choose whether or not to knock down a potion, sometimes it will choose a matching color, and sometimes it will choose a non-matching color."
	],
	[ # 0-2
		PotionData.Create(Colors.Purple),
		PotionData.Create(Colors.Gray),
		PotionData.Create(Colors.Gray),
		BookshelfObject.new(),
		
		DummyObject.new(),
		DummyObject.new(),
		DummyObject.new(),
		CatData.Create(Colors.Purple, Colors.Purple, false, false, false),
		
		BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(),  
		"I have a feeling that every time a cat encounters a potion, it will switch if it will knock down a matching color or not."
	],
	[ # 0-3
		BookshelfObject.new(), DummyObject.new(), BookshelfObject.new(), BookshelfObject.new(), 
		
		PotionData.Create(Colors.Purple),
		PotionData.Create(Colors.Gray),
		PotionData.Create(Colors.Orange),
		CatData.Create(Colors.Orange, Colors.Orange, false, false, false),
		
		BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(), 
		"The cats say that every individual cat will start with the same opinion!"
	],
	[ # 0-4
		BookshelfObject.new(), DummyObject.new(), BookshelfObject.new(), BookshelfObject.new(),
		
		BookshelfObject.new(),
		PotionData.Create(Colors.Orange),
		PotionData.Create(Colors.Orange),
		CatData.Create(Colors.Orange, Colors.Orange, false, false, false),
		
		CatData.Create(Colors.Orange, Colors.Orange, false, false, true),
		PotionData.Create(Colors.Gray),
		PotionData.Create(Colors.Gray),
		BookshelfObject.new(),
		
		"Alllllllllllllt+f4tooooooooooooooowininstaaaaaaantlyyyyyyyyyyyy!!!!!!!!111111111!!!!!!!!!!"
	],
	[ # 0-5
		CatData.Create(Colors.Orange, Colors.Orange, false, false, true),
		PotionData.Create(Colors.Orange),
		PotionData.Create(Colors.Orange),
		PotionData.Create(Colors.Orange),
		
		PotionData.Create(Colors.Gray),
		PotionData.Create(Colors.Gray),
		DummyObject.new(),
		CatData.Create(Colors.Gray, Colors.Gray, false, false, false),
		
		CatData.Create(Colors.Purple, Colors.Purple, false, false, true),
		PotionData.Create(Colors.Purple),
		PotionData.Create(Colors.Purple),
		DummyObject.new(),
		
		"Sorry, my cat stepped on my keyboard in the last level."
	],



	[ # 1-0
		BookshelfObject.new(),
		BookshelfObject.new(),
		PotionData.Create(Colors.Purple),
		BookshelfObject.new(),
		
		CatData.Create(Colors.Purple, Colors.Purple, false, true, true),
		DummyObject.new(),
		PotionData.Create(Colors.Orange),
		DummyObject.new(),
		
		BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(),
		"Strike That, Reverse It! There's cats with SOCKS!"
	],
	[ # 1-1
		BookshelfObject.new(), BookshelfObject.new(), DummyObject.new(), BookshelfObject.new(), 
		
		CatData.Create(Colors.Purple, Colors.Purple, false, true, true),
		PotionData.Create(Colors.Orange),
		PotionData.Create(Colors.Purple),
		PotionData.Create(Colors.Purple),
		
		BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(), 
	],
	[ # 1-2
		BookshelfObject.new(),
		BookshelfObject.new(),
		DummyObject.new(),
		BookshelfObject.new(),
		
		CatData.Create(Colors.Purple, Colors.Purple, false, true, true),
		PotionData.Create(Colors.Orange),
		PotionData.Create(Colors.Purple),
		PotionData.Create(Colors.Purple),
		
		CatData.Create(Colors.Gray, Colors.Gray, false, false, true),
		PotionData.Create(Colors.Gray),
		BookshelfObject.new(),
		BookshelfObject.new(),
	],
	[ # 1-3
		BookshelfObject.new(),
		PotionData.Create(Colors.Gray),
		BookshelfObject.new(),
		BookshelfObject.new(),
		
		CatData.Create(Colors.Orange, Colors.Orange, false, true, true),
		PotionData.Create(Colors.Gray),
		PotionData.Create(Colors.Purple),
		PotionData.Create(Colors.Orange),
		
		DummyObject.new(),
		PotionData.Create(Colors.Orange),
		PotionData.Create(Colors.Purple),
		CatData.Create(Colors.Purple, Colors.Purple, false, true, false),
	],
	[ # 1-4
		CatData.Create(Colors.Purple, Colors.Purple, false, true, true),
		PotionData.Create(Colors.Orange),
		BookshelfObject.new(),
		PotionData.Create(Colors.Purple),
		
		PotionData.Create(Colors.Gray),
		PotionData.Create(Colors.Orange),
		DummyObject.new(),
		CatData.Create(Colors.Gray, Colors.Gray, false, true, false),
		
		CatData.Create(Colors.Orange, Colors.Orange, false, true, true),
		PotionData.Create(Colors.Gray),
		PotionData.Create(Colors.Orange),
		PotionData.Create(Colors.Purple),
		
		"Hello! Hello hello!! Uhh, I wanted to record a message for you, making sure you were still causing mayhem!"
	],
	[ # 1-5
		CatData.Create(Colors.Purple, Colors.Purple, false, false, true),
		PotionData.Create(Colors.Purple),
		PotionData.Create(Colors.Purple),
		PotionData.Create(Colors.Orange),
		
		CatData.Create(Colors.Orange, Colors.Orange, false, true, true),
		PotionData.Create(Colors.Orange),
		PotionData.Create(Colors.Orange),
		PotionData.Create(Colors.Purple),
		
		CatData.Create(Colors.Gray, Colors.Gray, false, true, true),
		PotionData.Create(Colors.Gray),
		PotionData.Create(Colors.Gray),
		DummyObject.new(),
	],
	

	
	[ # 2-0
		BookshelfObject.new(),
		PotionData.Create(Colors.Gray, PotionData.Shapes.Triangle_Gray),
		BookshelfObject.new(),
		BookshelfObject.new(),
		
		DummyObject.new(),
		PotionData.Create(Colors.Gray, PotionData.Shapes.Circle_Orange),
		DummyObject.new(),
		CatData.Create(Colors.Gray, Colors.Orange, false, false, false),
		
		BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(), 
		"Uh-oh! The shapes of the potions have changed and so have the cat's spots! What does this mean?"
	],
	[ # 2-1
		BookshelfObject.new(),
		PotionData.Create(Colors.Purple, PotionData.Shapes.Circle_Orange),
		BookshelfObject.new(),
		BookshelfObject.new(),
		
		DummyObject.new(),
		PotionData.Create(Colors.Purple, PotionData.Shapes.Square_Purple),
		DummyObject.new(),
		CatData.Create(Colors.Purple, Colors.Orange, false, false, false),
		
		BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(), 
		"I wonder if there's any convenient colors and shapes you can see that could tell you what the cat's spots do."
	],
	[ # 2-2
		BookshelfObject.new(),
		PotionData.Create(Colors.Gray, PotionData.Shapes.Square_Purple),
		BookshelfObject.new(),
		BookshelfObject.new(), 
		
		DummyObject.new(),
		PotionData.Create(Colors.Gray, PotionData.Shapes.Triangle_Gray),
		DummyObject.new(),
		CatData.Create(Colors.Gray, Colors.Purple, false, false, false),
		
		BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(), 
	],
	[ # 2-3
		BookshelfObject.new(),
		PotionData.Create(Colors.Orange, PotionData.Shapes.Circle_Orange),
		BookshelfObject.new(),
		BookshelfObject.new(),
		
		DummyObject.new(),
		PotionData.Create(Colors.Orange, PotionData.Shapes.Square_Purple),
		DummyObject.new(),
		CatData.Create(Colors.Orange, Colors.Purple, false, false, false),
		
		BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(), 
	],
	[ # 2-4
		BookshelfObject.new(),
		PotionData.Create(Colors.Orange, PotionData.Shapes.Circle_Orange),
		BookshelfObject.new(),
		BookshelfObject.new(),
		
		DummyObject.new(),
		PotionData.Create(Colors.Orange, PotionData.Shapes.Triangle_Gray),
		DummyObject.new(),
		CatData.Create(Colors.Orange, Colors.Gray, false, false, false),
		
		BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(), 
	],
	[ # 2-5
		BookshelfObject.new(),
		PotionData.Create(Colors.Purple, PotionData.Shapes.Square_Purple),
		BookshelfObject.new(),
		BookshelfObject.new(), 
		
		DummyObject.new(),
		PotionData.Create(Colors.Orange, PotionData.Shapes.Triangle_Gray),
		PotionData.Create(Colors.Orange, PotionData.Shapes.Circle_Orange),
		CatData.Create(Colors.Orange, Colors.Gray, false, false, false),
		
		BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(), BookshelfObject.new(), 
	]
]

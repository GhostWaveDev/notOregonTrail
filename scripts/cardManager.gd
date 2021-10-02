extends Node2D

var cardScene = preload("res://scenes/card.tscn")

var card_list = []

func _ready():
	for i in range(0, 5):
		createCard(1, Vector2(0, 0), i)
	

func createCard(t, pos, h):
	var a = cardScene.instance()
	self.add_child(a)
	
	a._setup(t, pos, h)
	
	card_list.append(a)

extends Node2D

var cardScene = preload("res://scenes/card.tscn")

var card_list = []

func _ready():
	createCard(1, Vector2(0, 0), 1)
	createCard(1, Vector2(0, 0), 2)

func createCard(t, pos, h):
	var a = cardScene.instance()
	self.add_child(a)
	
	a._setup(t, pos, h)
	
	card_list.append(a)

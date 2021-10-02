extends Node2D

var cardScene = preload("res://scenes/card.tscn")

var card_list = []

signal clickedTypeToEvent(id)

func _ready():
	for i in range(0, 5):
		createCard(1, Vector2(0, 0), i)

func createCard(t, pos, h):
	var a = cardScene.instance()
	self.add_child(a)
	
	a._setup(t, pos, h)
	
	a.connect("clicked", self, "_on_clicked_card")
	
	card_list.append(a)

func _on_main_startListeningForCardClicks():
	for card in card_list:
		card.listening = true

func _on_clicked_card(card):
	emit_signal("clickedTypeToEvent", card.type)
	for card in card_list:
		card.listening = false

func removeCard(c):
	var i = 0
	var toremove = null
	for card in card_list:
		if card.hand_position == c.hand_position:
			toremove = i
		if card.hand_position > c.hand_position:
			card.hand_position -= 1
			card.changeState(1)

		print(card.hand_position)
		i += 1
	
	if toremove != null:
		card_list.remove(toremove)

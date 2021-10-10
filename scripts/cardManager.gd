extends Node2D

var cardScene = preload("res://scenes/card.tscn")

var card_list = []

var cardOk = [1, 2, 3, 4, 5, 6, 7, 8, 10]
var cardDark = [9, 12]

onready var soundSpecific = get_node("son")

signal clickedTypeToEvent(id)

func _ready():
	giveCards(1.5)

func giveCards(a):
	randomize()
	print("a :" + str(a))
	while len(card_list) < 5:
		if a > randf():
			createCard(cardOk[randi()%len(cardOk)], Vector2.ZERO, len(card_list))
		else:
			createCard(cardDark[randi()%len(cardDark)], Vector2.ZERO, len(card_list))

func createCard(t, pos, h):
	var a = cardScene.instance()
	self.add_child(a)
	
	a._setup(t, pos, h)
	
	a.connect("clicked", self, "_on_clicked_card")
	
	card_list.append(a)

func _on_main_startListeningForCardClicks():
	for card in card_list:
		if card.state == 4:
			return null
	for card in card_list:
		card.listening = true

func _on_clicked_card(card):
	for card in card_list:
		card.listening = false
	emit_signal("clickedTypeToEvent", card.type)

func removeCard(c):
	var i = 0
	var toremove = null
	for card in card_list:
		if card.hand_position == c.hand_position:
			toremove = i
		if card.hand_position > c.hand_position:
			card.hand_position -= 1
			card.changeState(1)

		i += 1
	
	if toremove != null:
		card_list.remove(toremove)

func transform(b):
	var c = card_list[randi() % len(card_list)]
	while c.state == 4:
		randomize()
		c = card_list[randi() % len(card_list)]
	
	if b != 12:
		for a in card_list:
			if a.type == 12:
				c = a
	
	c._setup(b, c.position, c.hand_position, true)

func _on_main_giveCard(a):
	giveCards(a)

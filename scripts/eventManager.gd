extends Node2D

onready var richText = get_node("text/richTextLabel")

var showText = false
var lapsed = 0.0

var waitingForCard = false
var currentEvent = 0

var cardPlayed = false

var sleeping = true

signal cardOk



func _event(a):
	sleeping = false
	self.visible = true
	if len(str(a)) == 1:
		a = "0" + str(a)
	_showText(tr("event" + str(a) + "-base"))
	currentEvent = "event" + str(a)
	waitingForCard = false
	cardPlayed = false

func _process(delta):
	if !sleeping:
		if showText:
			lapsed += delta
			richText.visible_characters = lapsed/0.1
		
		if Input.is_action_just_pressed("click"):
			richText.visible_characters = richText.get_total_character_count()
		
		if richText.get_total_character_count() != 0:
			if richText.visible_characters/richText.get_total_character_count() and (!waitingForCard or cardPlayed):
				showText = false
				if !waitingForCard:
					emit_signal("cardOk")
				waitingForCard = true
				
				
				if cardPlayed:
					yield(get_tree().create_timer(2), "timeout")
					self.visible = false
					cardPlayed = true
					sleeping = true

func _showText(data):
	richText.text = data
	lapsed = 0.0
	showText = true

func getCardType(a):
	if len(str(a)) == 1:
		a = "0" + str(a)
	_showText(tr(currentEvent + "-" + str(a)))
	cardPlayed = true


extends Node2D

onready var richText = get_node("text/richTextLabel")

var showText = false
var lapsed = 0.0

var waitingForCard = false
var currentEvent = 0

var cardPlayed = false

var sleeping = true

signal cardOk
signal eventDone

signal bilanStab(a, b)

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
			lapsed += delta*5
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
					yield(get_tree().create_timer(4), "timeout")
					self.visible = false
					cardPlayed = false
					sleeping = true
					emit_signal("eventDone")

func _showText(data):
	richText.bbcode_text = data
	lapsed = 0.0
	showText = true

func getCardType(a):
	if len(str(a)) == 1:
		a = "0" + str(a)

	var u = tr(currentEvent + "-" + str(a))
	var value = int(u[0] + u[1] + u[2])
	var give = -1
	
	u.erase(0, 3)
	
	if u[0] == ">":
		give = int(u[1] + u[2])
		print("Giving : " + str(give))
		u.erase(0, 3)
	
	emit_signal("bilanStab", value, give)

	if value < 0:
		u += ("\n\n[color=#9a3636]Stability : " + "lose " + str(value) + "[/color]")
	if value > 0:
		u += ("\n\n[color=#2b6531]Stability : " + "gain " + str(value) + "[/color]")
	if value == 0:
		u += ("\n\nStability : 0")

	_showText(u)

	cardPlayed = true


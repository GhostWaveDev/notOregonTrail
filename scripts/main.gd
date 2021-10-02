extends Node2D


var stability = 100

signal startListeningForCardClicks

func _ready():
	self.connect("startListeningForCardClicks", $cardManager, "_on_main_startListeningForCardClicks")
	$cardManager.connect("clickedTypeToEvent", $eventManager, "getCardType")
	$cardManager.connect("clickedTypeToEvent", self, "effect")

func _on_eventManager_cardOk():
	emit_signal("startListeningForCardClicks")

func loseStability(a):
	$bar.minusBar(a)

func effect(a):
	
	if a == 1: #ROCK
		loseStability(50)

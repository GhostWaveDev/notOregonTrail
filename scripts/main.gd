extends Node2D

var stability = 100

var hotel = 10
var eventsOk = [1, 2, 3]
var eventsMeh = []
var eventsGood = []

var eventTest = true

var counter = 1

signal startListeningForCardClicks
signal giveCard(a)

func _ready():
	_on_eventManager_eventDone()
	self.connect("startListeningForCardClicks", $cardManager, "_on_main_startListeningForCardClicks")
	$cardManager.connect("clickedTypeToEvent", $eventManager, "getCardType")
	$cardManager.connect("clickedTypeToEvent", self, "effect")

func _on_eventManager_cardOk():
	emit_signal("startListeningForCardClicks")

func loseStability(a):
	stability -= a
	$bar.minusBar(a)

func gainStability(a):
	stability += a
	$bar.plusBar(a)

func effect(a):
	
	if a == 1: #ROCK
		loseStability(4)
	
	if a == 2: #SWORD
		loseStability(18)
	
	if a == 4: #MEDITATE
		gainStability(10)
	
	if a == 5: #FLOWER
		gainStability(10)

func event(a) :
	$eventManager._event(a)

func _on_enemyManager_faireEvenement(type):
	if type != 10:
		event(type)
		eventTest = true
	else:
		emit_signal("giveCard", stability/100)
		_on_eventManager_eventDone()

func _on_eventManager_eventDone():
	if eventTest:
		randomize()
		if (counter % 4) != 0:
			$enemyManager.installEnemy(eventsOk[randi() % len(eventsOk)])
			print("enemy")
		else:
			$enemyManager.installEnemy(hotel)
			print("hotel")
		
		eventTest = false
		counter += 1
	
	

func _on_eventManager_bilanStab(a):
	if a > 0:
		gainStability(a)
	if a < 0:
		loseStability(a)

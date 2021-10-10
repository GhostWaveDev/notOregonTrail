extends Node2D

var stability = 150.0

var hotel = 10
var eventsOk = [1, 2, 6, 11, 13]
var eventsMeh = [1, 5, 6, 8, 11, 16]
var eventsHorrible = [7, 8, 9, 34, 12, 14, 15]

var eventTest = true
var ambianceList = [load("res://music/ambiance1(boucle).wav"), load("res://music/ambiance2(boucle).wav"), load("res://music/ambiance3(boucle).wav")]
var counter = 1

var previousEvent = -1

var musiqueCounter = 0
var music_position

var envi = 0

signal startListeningForCardClicks
signal chg_envi
signal giveCard(a)

func _ready():
	_on_eventManager_eventDone()
	self.connect("startListeningForCardClicks", $cardManager, "_on_main_startListeningForCardClicks")
	$cardManager.connect("clickedTypeToEvent", $eventManager, "getCardType")
	$cardManager.connect("clickedTypeToEvent", self, "effect")

func _on_eventManager_cardOk():
	emit_signal("startListeningForCardClicks")

func _process(delta):
	if Global.pauseMusic:
		if $musique.stream_paused == false:
			$musique.stream_paused = true
	else:
		if $musique.stream_paused == true:
			$musique.stream_paused = false
	
	if envi == 0 and stability < 90:
		modulate.r += delta * 30
		modulate.g += delta * 30
		modulate.b += delta * 30
		
		if modulate.r > 10.0:
			envi += 1
			emit_signal("chg_envi")
	
	if envi == 1 and modulate.r > 0:
		modulate.r -= delta * 10
		modulate.g -= delta * 10
		modulate.b -= delta * 10
	
	if modulate.r < 1:
		modulate.r = 1
		modulate.g = 1
		modulate.b = 1
	
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
	
	if a == 6: #SPIRIT
		loseStability(25)
	
	if a == 7: #DOG
		gainStability(5)
	
	if a == 8: #FOOD
		gainStability(10)
	
	if a == 11: #GEM
		pass

	if a == 12: #GAME OVER
		get_tree().change_scene("res://scenes/end.tscn")
	
func event(a) :
	$eventManager._event(a)

func _on_enemyManager_faireEvenement(type):
	if type != 10:
		event(type)
		eventTest = true
	else:
		print(stability)
		emit_signal("giveCard", stability/100)
		print(stability/100)
		eventTest = true
		_on_eventManager_eventDone()

func _on_eventManager_eventDone():
	if eventTest:
		print('---------------- ***')
		randomize()
		if (counter % 4) != 0:
			var list = eventsOk.duplicate() + eventsOk.duplicate() +  eventsMeh.duplicate() + eventsHorrible.duplicate()
			
			if envi == 0:
				list.append(3)
				list.append(4)
			
			if stability < 120:
				list += eventsMeh.duplicate() + eventsHorrible.duplicate()
			if stability < 70:
				list = eventsMeh.duplicate() + eventsHorrible.duplicate()
			if stability < 20:
				list = eventsHorrible.duplicate()
			var h = list[randi() % len(list)]
			
			while h == previousEvent:
				h = list[randi() % len(list)]
			
			previousEvent = h
			
			$enemyManager.installEnemy(h)
			print("list possible : " + str(list))
			print("--> enemy" + str(h))
		else:
			$enemyManager.installEnemy(hotel)
			("--> hotel")
			counter = 0
		
		eventTest = false
		counter += 1

func _on_eventManager_bilanStab(a, b):
	if a > 0:
		gainStability(a)
	if a < 0:
		loseStability(abs(a))
	
	if b > 0:
		$cardManager.transform(b)

func _on_ambiance_finished():
	$ambiance.stream = ambianceList[randi() % len(ambianceList)]
	print("ambiance : " + str($ambiance.stream))
	$ambiance.play()

func _on_musique_finished():
	if musiqueCounter == 0:
		$musique.stream = load("res://music/musique-intro-intro.wav")
		musiqueCounter += 1
	elif stability > 50:
		$musique.stream = load("res://music/musique-boucle.wav")
	else:
		$musique.stream = load("res://music/musique-epique.wav")
	print("musique : " + str($musique.stream))
	$musique.play()


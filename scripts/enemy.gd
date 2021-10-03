extends Node2D

onready var sprite = get_node("enemySprite")

var type = 1
var state = 0

signal faireEvenement(t)

# 1 : Brigand
# 2 : Marchand
# 3 : Brigand Pont
# 4 : Monstre Pont
# 5 : Arbre
# 6 : Stray Dog
# 7 : Child
# 8 : Rabbit
# 9 : Fire
# 10 : Hotel
# 11 : Knight
# 34 : Devil


func _setup(t,p) :
	type = t
	self.position = p
	setSprite(t)
	setSound()
	
	if type == 3 or type == 4:
		$bridge.visible = true
	
	if type == 5:
		$enemySprite.position.y = -240
	
func _process(delta):
	if state == 0:
		position.x += -12*delta*Global.speed
	
	if !Global.pauseMusic and type != 10:
		$sound.stream_paused = true

func checkPos(vec2):
	if position.x < vec2 + 80 and state == 0:
		changeState(1)
		$sound.stream_paused = false
		$sound.play()
		emit_signal("faireEvenement", type)

func changeState(a):
	state = a 

func setSprite(a):
	$enemySprite.animation = str(a)

func setSound():
	var sound = load("res://sound/enemy" + str(type) + ".wav")
	$sound.stream = sound

#func signalEvenement():
#	if position.x < player.position.x + 80 :
#		emit_signal('faireEvenement')

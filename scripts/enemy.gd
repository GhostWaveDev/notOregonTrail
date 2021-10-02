extends Node2D

onready var sprite = get_node("enemySprite")

var type = 1
var state = 0

signal faireEvenement(t)

func _setup(t,p) :
	type = t
	self.position = p
	setSprite(t)
	
func _process(delta):
	if state == 0:
		position.x += -12*delta


func checkPos(vec2):
	if position.x < vec2 + 80 and state == 0:
		changeState(1)
		emit_signal("faireEvenement", type)


func changeState(a):
	state = a 


func setSprite(a):
	$enemySprite.animation = str(a)

#
#func signalEvenement():
#	if position.x < player.position.x + 80 :
#		emit_signal('faireEvenement')

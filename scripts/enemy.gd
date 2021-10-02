extends Node2D

onready var sprite = get_node("enemySprite")

var type = 0
var state = 0

signal faireEvenement(t)

func _setup(t,p) :
	type = t
	print(p)
	self.position = p
	
func _process(delta):
	if state == 0 :
		position.x += -30*delta


func checkPos(vec2):
	if position.x < vec2 + 80 and state == 0:
		changeState(1)
		emit_signal("faireEvenement", type)


func changeState(a):
	state = a 


#
#func signalEvenement():
#	if position.x < player.position.x + 80 :
#		emit_signal('faireEvenement')

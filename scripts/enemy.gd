extends Node2D

onready var sprite = get_node("enemySprite")

var type = 0
var state = 0

func _setup(t,p) :
	type = t
	self.position = p
	
func _process(delta):
	if state == 0 :
		position.x += -10*delta

func changeState(a):
	state = a 

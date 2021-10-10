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
# 12 : Witch
# 13 : Minstrel
# 14 : German
# 15 : Mini phantome



func _setup(t,p) :
	type = t
	self.position = p
	setSprite(t)
	setSound()
	
	if type == 3 or type == 4:
		$bridge.visible = true
	
	if type == 5:
		$enemySprite.position.y = -145
	
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
		
		if type == 1:
			$sound.volume_db = -8
		if type == 2:
			$sound.volume_db = 4
		if type == 3:
			$sound.volume_db = -8
		if type == 4:
			$sound.volume_db = 0
		if type == 5:
			$sound.volume_db = 0
		if type == 6:
			$sound.volume_db = 0
		if type == 7:
			$sound.volume_db = 0
		if type == 8:
			$sound.volume_db = -20
		if type == 9:
			$sound.volume_db = -8
		if type == 34:
			$sound.volume_db = 0
		if type == 11:
			$sound.volume_db = -15
		if type == 12:
			$sound.volume_db = -8
		if type == 13:
			$sound.volume_db = -4
		if type == 14:
			$sound.volume_db = 4
		if type == 15:
			$sound.volume_db = -8
		
		
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

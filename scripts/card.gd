extends Node2D

var state : int
var type : int

var target = Vector2.ZERO
var speed = 7
var stability = 0

var hand_position = 0

var listening = false

signal clicked(s)

onready var stabText = get_node("text/stability")
onready var titleText = get_node("text/title")

var sigmaVector = Vector2(0.01, 0.01)

var stabData = [0, -4, -18, 0, 10, 2, -25, 5, 10, 0, 0]

func _setup(t, pos, h):
	self.position = pos
	type = t
	hand_position = h
	setStability(-1)
	setTitle(type)
	loadSprite()
	changeState(1)
	stability = stabData[type]
	setStability(stability)

func loadSprite():
	var texture
	if type == 1:
		texture = load("res://sprites/cards/rock.png")
	if type == 2:
		texture = load("res://sprites/cards/sword.png")
	if type == 3:
		texture = load("res://sprites/cards/run.png")
	if type == 4:
		texture = load("res://sprites/cards/meditation.png")
	if type == 5:
		texture = load("res://sprites/cards/flower.png")
	if type == 7:
		texture = load("res://sprites/cards/dog.png")
	if type == 10:
		texture = load("res://sprites/cards/coin.png")
	
	$artFront/sprite.texture = texture

func _process(delta):
	toTarget(target, delta)
	
	if state == 1:
		if sigmaCheck(target, self.position):
			changeState(2)
	
	if state == 3:
		if Input.is_action_just_pressed("click") and listening:
			emit_signal("clicked", self)
			changeState(4)
	
	if state == 4:
		if sigmaCheck(target, self.position):
			destroy()
	
func changeState(a):
	state = a
	
	# State : 1 --> To hand
	if a == 1:
		target = Vector2(14 + (55 * hand_position), 149)
	
	# State : 2 --> In hand
	if a == 2:
		target = Vector2(14 + (55 * hand_position), 149)
	
	# State : 3 --> Hover
	if a == 3:
		target = Vector2(14 + (55 * hand_position), 129)
	
	# State : 4 --> Disapear
	if a == 4:
		target = Vector2(14 + (55 * hand_position), -119)

func toTarget(t, d):
	self.global_position = lerp(self.global_position, t, speed*d)

func sigmaCheck(vec1, vec2):
	if abs(vec1.x - vec2.x) > sigmaVector.x:
		return false
	if abs(vec1.y - vec2.y) > sigmaVector.y:
		return false
	return true

func _on_hitbox_mouse_entered():
	if state == 2:
		changeState(3)

func _on_hitbox_mouse_exited():
	if state == 3: 
		changeState(2)

func setStability(a):
	var b = ""
	if a > 0:
		b = "+"
	stabText.text = b + str(a) + " stab"
	if a == 0:
		stabText.text = ""

func setTitle(a):
	var title = ""
	if a == 1:
		title = "ROCK"
	if a == 2:
		title = "SWORD"
	if a == 3:
		title = "RUN"
	if a == 4:
		title = "MEDITATE"
	if a == 5:
		title = "FLOWER"
	if a == 6:
		title = "SPIRIT"
	if a == 7:
		title = "DOG"
	if a == 8:
		title = "FOOD"
	if a == 9:
		title = "HANDS"
	if a == 10:
		title = "GOLD"
	if a == 11:
		title = "GEM"
	if a == 12:
		title = "UNSTABLE"
	
	titleText.text = title

func destroy():
	get_parent().removeCard(self)
	self.queue_free()

extends Node2D

var state : int
var type : int

var target = Vector2.ZERO
var speed = 0.1

var hand_position = 0

var listening = false

signal clicked(s)

onready var stabText = get_node("text/stability")
onready var titleText = get_node("text/title")

var sigmaVector = Vector2(0.01, 0.01)

func _setup(t, pos, h):
	self.position = pos
	type = t
	hand_position = h
	setStability(-1)
	setTitle("rock")
	
	changeState(1)

func _process(delta):
	toTarget(target)
	
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
			print("yo")
	
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

func toTarget(t):
	self.global_position = lerp(self.global_position, t, speed)

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

func setTitle(a):
	a = a.to_upper()
	
	titleText.text = a

func destroy():
	get_parent().removeCard(self)
	self.queue_free()

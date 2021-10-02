extends Node2D

var state : int
var type : int

var target = Vector2.ZERO
var speed = 0.1

var hand_position = 0

var sigmaVector = Vector2(0.01, 0.01)

func _setup(t, pos, h):
	self.position = pos
	type = t
	hand_position = h
	
	changeState(1)

func _process(delta):
	toTarget(target)
	
	if state == 1:
		if sigmaCheck(target, self.position):
			changeState(2)

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

func toTarget(t):
	self.global_position = lerp(self.global_position, t, speed)

func sigmaCheck(vec1, vec2):
	if abs(vec1.x - vec2.x) > sigmaVector.x:
		return false
	if abs(vec1.y - vec2.y) > sigmaVector.y:
		return false
	return true

func _on_hitbox_mouse_entered():
	changeState(3)

func _on_hitbox_mouse_exited():
	changeState(2)

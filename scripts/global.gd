extends Node

var speed = 1
var pauseMusic = false

func _process(delta):
	if Input.is_action_pressed("space") or Input.is_action_pressed("click"):
		speed = 4
	else:
		speed = 1

func pausetheMusic():
	pauseMusic = true

func unpauseMusic():
	pauseMusic= false

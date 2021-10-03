extends Node2D

var walking = true
var once = true

func _ready():
	walk()

func walk():
	if once:
		$player.animation = "walk"
		walking = true
		$pas.play()
		once = false
		Global.unpauseMusic()

func stop():
	$player.play("idle")
	walking = false
	$pas.playing = false
	once = true
	Global.pausetheMusic()

func _on_pas_finished():
	if walking: $pas.play()

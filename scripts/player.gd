extends Node2D


func _ready():
	walk()

func walk():
	$player.animation = "walk"

func stop():
	$player.play("idle")

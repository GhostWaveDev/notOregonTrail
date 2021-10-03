extends Node2D


onready var text = get_node("fore/text")
var lapsed = 0.0
var speed = 1

var changescene = false
var scene = preload("res://scenes/main.tscn")

func _process(delta):
	lapsed += delta * speed
	text.visible_characters = lapsed/0.1
	
	if Input.is_action_pressed("click"):
		speed = 10
	else:
		speed = 1
	
	if Input.is_action_pressed("space"):
		get_tree().change_scene("res://scenes/main.tscn")
	
	if text.visible_characters == text.get_total_character_count():
		yield(get_tree().create_timer(2), "timeout")
		get_tree().change_scene("res://scenes/main.tscn")

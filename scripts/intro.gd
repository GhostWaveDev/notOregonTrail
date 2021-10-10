extends Node2D


onready var text = get_node("fore/text")
var lapsed = 0.0
var speed = 1

var changescene = false
var scene = preload("res://scenes/main.tscn")

var blabla = []
var alternate = 0

func _ready():
	for i in range(1, 15):
		blabla.append(load("res://sound/blabla " + str(i) + ".wav"))

func _process(delta):
	lapsed += delta * speed
	text.visible_characters = lapsed/0.1
	
	if (alternate % 3 == 0) or (Input.is_action_pressed("click")):
		$sound.stream = blabla[randi() % len(blabla)]
		$sound.play()
	
	alternate += 1
	
	if Input.is_action_pressed("click"):
		speed = 10
	else:
		speed = 1
	
	if Input.is_action_pressed("space"):
		get_tree().change_scene("res://scenes/main.tscn")
	
	if text.visible_characters >= text.get_total_character_count():
		$sound.stream_paused = true
		yield(get_tree().create_timer(2), "timeout")
		get_tree().change_scene("res://scenes/main.tscn")

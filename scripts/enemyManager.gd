extends Node2D

var enemyScene = preload("res://scenes/enemy.tscn")
var playerScene = preload("res://scenes/player.tscn")

onready var player = $player

var enemy_list = []

var state = 0
var moving = true
onready var floors = [$floor1, $floor2]
onready var forests = [$background1, $background2]

signal faireEvenement(type)

func _ready():
	player.position = Vector2(64, 113)  

func createEnemy(type, pos:Vector2):
	var a = enemyScene.instance()
	add_child(a)
	a.connect("faireEvenement", self, "doEvent")
	a._setup(type, pos)
	
	enemy_list.append(a)

func installEnemy(n):
	if state < 5 :
		createEnemy(n, Vector2(360,78))
		state += 1

func _process(delta):
	for enemy in enemy_list:
		enemy.checkPos(player.position.x)
	
	if moving:
		for f in floors:
			f.position.x -= 12*delta
			if f.position.x < -1200:
				f.position.x = 2368
		
		for f in forests:
			if f.position.x < -296:
				f.position.x = 296*2
			f.position.x -= 8*delta
		
		for enemy in enemy_list:
			if enemy.state == 1:
				enemy.position.x += -30*delta

func doEvent(a):
	emit_signal("faireEvenement", a)
	if a != 10:
		moving = false
		player.stop()

func _on_eventManager_eventDone():
	moving = true
	player.walk()

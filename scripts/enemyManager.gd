extends Node2D

var enemyScene = preload("res://scenes/enemy.tscn")
var playerScene = preload("res://scenes/player.tscn")

onready var player = $player

var enemy_list = []

var state = 0

signal faireEvenement(type)

func _ready():
	installEnemy(0)
	player.position = Vector2(64, 116)  

func createEnemy(type, pos:Vector2):
	var a = enemyScene.instance()
	add_child(a)
	a.connect("faireEvenement", self, "doEvent")
	a._setup(type, pos)
	
	enemy_list.append(a)
#
#func signalEvenement():
#	if 
#	emit_signal('faireEvenement')

func installEnemy(n):
	if state < 5 :
		createEnemy(n, Vector2(360,70))
		state += 1

func _process(delta):
	for enemy in enemy_list:
		enemy.checkPos(player.position.x)
	

func doEvent(a):
	emit_signal("faireEvenement", a)

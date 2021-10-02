extends Node2D

var enemyScene = preload("")

var enemy_list = []

func _ready():
	createEnemy(a,p)
	createCard(1, Vector2(0, 0), 2)

func createEnemy(type, pos):
	var a = enemyScene.instance()
	add_child(a)
	
	a._setup(type, pos)
	
	enemy_list.append(a)


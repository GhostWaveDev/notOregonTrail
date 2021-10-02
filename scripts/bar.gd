extends Node2D

onready var rectWhite = get_node("whiteRect")
onready var rectBlack = get_node("blackRect")
onready var rectRed = get_node("redRect")

var speed = 2

func _ready():
	updateBar(100)

func _process(delta):
	rectRed.rect_size.x = lerp(rectRed.rect_size.x, rectBlack.rect_size.x, speed*delta)

func updateBar(a) :
	rectBlack.rect_size.x = a; 

func plusBar(a) :
	rectBlack.rect_size.x += a;
	
func minusBar(a) :
	rectBlack.rect_size.x -= a;

extends Node2D

var b 
onready var rectWhite = get_node("whiteRect")
onready var rectBlack = get_node("blackRect")
func _ready():
	updateBar(50)
	plusBar(50)
	
func updateBar(a) :
	rectBlack.rect_size.x = a; 

func plusBar(a) :
	rectBlack.rect_size.x += a;
	
func minusBar(a) :
	rectBlack.rect_size.x -= a;

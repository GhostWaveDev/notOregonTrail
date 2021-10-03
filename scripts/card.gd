extends Node2D

var state : int
var type : int

var target = Vector2.ZERO
var speed = 7
var stability = 0

var hand_position = 0

var listening = false

signal clicked(s)

onready var stabText = get_node("text/stability")
onready var titleText = get_node("text/title")

onready var basesounds = [preload("res://sound/clique carte bis.wav"), preload("res://sound/carte 3.wav"), preload("res://sound/clique carte2 .wav")]
var hoverSound = preload("res://sound/passe la souris sur carte.wav")
var cardSound

var sigmaVector = Vector2(0.01, 0.01)

var stabData = [0, -4, -18, 0, 10, 2, -25, 5, 10, -10, 0, 0, -64]

func _setup(t, pos, h, ex = false):
	self.position = pos
	type = t
	hand_position = h
	setStability(-1)
	setTitle(type)
	loadSprite()
	loadSound()
	changeState(1)
	stability = stabData[type]
	setStability(stability)
	if ex:
		$poof.emitting = true
		yield(get_tree().create_timer(1), "timeout")
		$poof.emitting = false

func loadSprite():
	var texture
	$artBack/sprite.animation = "1"
	$text.modulate = Color("#3e3e3e")
	if type == 1:
		texture = load("res://sprites/cards/rock.png")
	if type == 2:
		texture = load("res://sprites/cards/sword.png")
	if type == 3:
		texture = load("res://sprites/cards/run.png")
	if type == 4:
		texture = load("res://sprites/cards/meditation.png")
	if type == 5:
		texture = load("res://sprites/cards/flower.png")
	if type == 6:
		texture = load("res://sprites/cards/spirit.png")
		$artBack/sprite.animation = "2"
		$text.modulate = Color("#6d0f91")
	if type == 7:
		texture = load("res://sprites/cards/dog.png")
	if type == 8:
		texture = load("res://sprites/cards/food.png")
	if type == 9:
		texture = load("res://sprites/cards/hand.png")
		$artBack/sprite.animation = "2"
		$text.modulate = Color("#6d0f91")
	if type == 10:
		texture = load("res://sprites/cards/coin.png")
	if type == 11:
		texture = load("res://sprites/cards/gem.png")
	if type == 12:
		texture = load("res://sprites/cards/death.png")
		$artBack/sprite.animation = "2"
		$text.modulate = Color("#6d0f91")
	
	$artFront/sprite.texture = texture

func loadSound():
	var sound
	if type == 1:
		sound = load("res://sound/rock-stone.wav")
	if type == 2:
		if (randf() > 0.5):
			sound = load("res://sound/epee.wav")
		else:
			sound = load("res://sound/Epee 2.wav")
	if type == 3:
		sound = load("res://sound/fuite.wav")
	if type == 4:
		sound = load("res://sound/meditation.wav")
	if type == 5:
		sound = load("res://sound/fleur.wav")
	if type == 6:
		sound = load("res://sound/esprit sympa (phatome).wav")
	if type == 7:
		sound = load("res://sound/chien.wav")
	if type == 8:
		sound = load("res://sound/Food.wav")
	if type == 9:
		pass
	if type == 10:
		sound = load("res://sound/piece de monnaies.wav")
	if type == 11:
		pass
	if type == 12:
		pass
	
	cardSound = sound

func _process(delta):
	toTarget(target, delta)
	
	if state == 1:
		if sigmaCheck(target, self.position):
			changeState(2)
	
	if state == 3:
		if Input.is_action_just_pressed("click") and listening:
			changeState(4)
			emit_signal("clicked", self)
			playSound("base")
			if cardSound != null:
				get_parent().soundSpecific.stream = cardSound
				get_parent().soundSpecific.play()
	
	if state == 4:
		if sigmaCheck(target, self.position):
			destroy()
	
func changeState(a):
	state = a
	
	# State : 1 --> To hand
	if a == 1:
		target = Vector2(14 + (55 * hand_position), 149)
	
	# State : 2 --> In hand
	if a == 2:
		target = Vector2(14 + (55 * hand_position), 149)
	
	# State : 3 --> Hover
	if a == 3:
		target = Vector2(14 + (55 * hand_position), 129)
	
	# State : 4 --> Disapear
	if a == 4:
		target = Vector2(14 + (55 * hand_position), -119)

func toTarget(t, d):
	self.global_position = lerp(self.global_position, t, speed*d)

func sigmaCheck(vec1, vec2):
	if abs(vec1.x - vec2.x) > sigmaVector.x:
		return false
	if abs(vec1.y - vec2.y) > sigmaVector.y:
		return false
	return true

func _on_hitbox_mouse_entered():
	if state == 2:
		changeState(3)
		playSound("hover")

func _on_hitbox_mouse_exited():
	if state == 3: 
		changeState(2)

func setStability(a):
	var b = ""
	if a > 0:
		b = "+"
	stabText.text = b + str(a) + " stab"
	if a == 0:
		stabText.text = ""
	if a == -64:
		stabText.text = "Die"

func setTitle(a):
	var title = ""
	if a == 1:
		title = "ROCK"
	if a == 2:
		title = "SWORD"
	if a == 3:
		title = "RUN"
	if a == 4:
		title = "MEDITATE"
	if a == 5:
		title = "FLOWER"
	if a == 6:
		title = "SPIRIT"
	if a == 7:
		title = "DOG"
	if a == 8:
		title = "FOOD"
	if a == 9:
		title = "HANDS"
	if a == 10:
		title = "GOLD"
	if a == 11:
		title = "GEM"
	if a == 12:
		title = "UNSTABLE"
	
	titleText.text = title

func destroy():
	get_parent().removeCard(self)
	self.queue_free()

func playSound(b):
	var sound
	if b == "base":
		sound = basesounds[randi()%len(basesounds)]
	if b == "hover":
		sound = hoverSound
	
	$sound.stream = sound
	$sound.play()
	

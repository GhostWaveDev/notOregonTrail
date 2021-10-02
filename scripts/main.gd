extends Node2D

signal startListeningForCardClicks

func _ready():
	self.connect("startListeningForCardClicks", $cardManager, "_on_main_startListeningForCardClicks")
	$cardManager.connect("clickedTypeToEvent", $eventManager, "getCardType")

func _on_eventManager_cardOk():
	emit_signal("startListeningForCardClicks")

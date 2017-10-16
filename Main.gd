extends Node

const SCROLL_SPEED = 60

func _ready():
	set_process_input(true)
	$BackgroundScroller.speed = SCROLL_SPEED
	$GroundScroller.speed = SCROLL_SPEED

func _input(event):
	if event.is_action_pressed("flap"):
		$Bird.flap()

func _on_Bird_died():
	$BackgroundScroller.speed = 0
	$GroundScroller.speed = 0
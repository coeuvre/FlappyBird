extends "res://Scroller.gd"

func _scroll(node):
	._scroll(node)
	node.position.x -= randi() % 20 
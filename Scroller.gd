extends Node2D

export var speed = 0
export var gap = 0

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	for child in get_children():
		if child.position != null:
			child.position.x -= speed * delta
			if child.position.x + gap < 0:
				child.position.x += get_child_count() * gap
extends Node2D

export var x_speed = 50
export var gravity = 400
export var jump = 160

var a = Vector2(0, gravity)
var v = Vector2(x_speed, 0)

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	var old_v = v
	v = old_v + a * delta
	position += v * delta - 0.5 * a * delta * delta
	
	rotation = Vector2(1, 0).angle_to(v)

func flap():
	v = Vector2(x_speed, -jump)
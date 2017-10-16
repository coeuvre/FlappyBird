extends Node2D

export var gravity = 400
export var jump = 160

var a = Vector2(0, gravity)
var velocity = Vector2(0, 0)
var angular_velocity = 0

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	var old_velocity = velocity
	velocity = old_velocity + a * delta
	position += velocity * delta - 0.5 * a * delta * delta
	
	if velocity.y > 0:
		angular_velocity = 1.5
	
	rotation += angular_velocity * delta
	
	if rotation_deg < -30:
		rotation_deg = -30
		angular_velocity = 0
	
	if rotation_deg > 30:
		rotation_deg = 30
		angular_velocity = 0

func flap():
	velocity = Vector2(0, -jump)
	angular_velocity = -3.0
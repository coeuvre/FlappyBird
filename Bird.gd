extends Area2D

export var fall = 580
export var jump = 150

signal died

enum Status { FLYING, DIED }

var status = Status.FLYING
var a = Vector2(0, fall)
var velocity = Vector2(0, 0)
var angular_velocity = 0

func flap():
	velocity = Vector2(0, -jump)
	angular_velocity = -3.0

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	var old_velocity = velocity
	velocity = old_velocity + a * delta
	position += velocity * delta - 0.5 * a * delta * delta
	
	match status:
		Status.FLYING:
			if velocity.y > 0:
				angular_velocity = 1.5
			
			rotation += angular_velocity * delta
			
			if rotation_deg < -30:
				rotation_deg = -30
				angular_velocity = 0
			
			if rotation_deg > 30:
				rotation_deg = 30
				angular_velocity = 0

func _on_Bird_area_entered(area):
	if area.is_in_group("Pipe") or area.is_in_group("Ground"):
		_die()

func _die():
	status = Status.DIED
	velocity = Vector2(0, -jump)
	angular_velocity = 0
	rotation = PI / 2
	call_deferred("set_monitoring", false)
	call_deferred("set_monitorable", false)
	emit_signal("died")
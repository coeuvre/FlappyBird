extends Area2D

const FALL = 580
const JUMP = 150

signal died

enum Status { FLYING, DIED }

var status = Status.FLYING
var a = Vector2(0, FALL)
var velocity = Vector2(0, 0)
var angular_velocity = 0

func flap():
	if status == Status.FLYING:
		velocity = Vector2(0, -JUMP)
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
				angular_velocity = 2.0
			
			rotation += angular_velocity * delta
			
			if rotation_deg < -30:
				rotation_deg = -30
				angular_velocity = 0
			
			if rotation_deg > 60:
				rotation_deg = 60
				angular_velocity = 0

func _on_Bird_area_entered(area):
	if area.is_in_group("Pipe") or area.is_in_group("Ground"):
		_die()

func _die():
	status = Status.DIED
	velocity = Vector2(0, -JUMP)
	angular_velocity = 0
	rotation = PI / 2
	call_deferred("set_monitoring", false)
	call_deferred("set_monitorable", false)
	emit_signal("died")
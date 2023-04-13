extends CharacterBody2D
class_name Bullet

const LIFETIME = 3

var speed: int
var direction: Vector2
var elevation: float

var time_lived: float = 0

func _physics_process(delta):
	time_lived += delta
	
	velocity = direction * speed
	
	move_and_slide()
	
	if time_lived > LIFETIME:
		queue_free()

func _get_class():
	return Bullet

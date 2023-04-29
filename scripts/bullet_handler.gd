extends CustomCharacter
class_name Bullet

const LIFETIME = 3

var speed: int
var direction: Vector2
var time_lived: float = 0
var penetration_power: int = 1

func _physics_process(delta):
	super(delta)
	
	time_lived += delta
	
	velocity = direction * speed
	
	move_and_slide()
	
	if time_lived > LIFETIME:
		queue_free()

func handle_hit(_col):
	penetration_power -= 1
	if penetration_power <= 0:
		hitbox.monitoring = false
		queue_free()

func _get_class():
	return Bullet


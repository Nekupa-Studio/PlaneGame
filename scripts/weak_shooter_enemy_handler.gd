extends Planes
class_name Enemy

var speed: int = 60
var direction := Vector2(0,1)

@onready var sprite = $sprite
	
func handle_hit(col):
	if col is Bullet or col is Player:
		crash_plane()

func _physics_process(delta):
	super(delta)
	velocity = direction * speed
	move_and_slide()
	
	print(position.y)
	
	if position.y > 550 or position.y < 0:
		sprite.flip_v = !sprite.flip_v
		direction = -direction


func _get_class():
	return Enemy

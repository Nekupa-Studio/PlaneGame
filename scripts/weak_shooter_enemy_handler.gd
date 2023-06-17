extends Planes
class_name Enemy

var speed: int = 120
var direction := Vector2(0,1)
var textures = [preload("res://imports/test_ennemis.png"), preload("res://imports/ennemis_planegame_base_reverse.png")]
var texture_index := 0

@onready var sprite = $sprite
	
func handle_hit(col):
	if col is Bullet or col is Player:
		crash_plane()

func _physics_process(delta):
	super(delta)
	velocity = direction * speed
	move_and_slide()
	
	if position.y > 600 or position.y < -100:
		texture_index = (texture_index + 1) % 2
		sprite.texture = textures[texture_index]
		shadow.flip_v = !shadow.flip_v
		direction = -direction


func _get_class():
	return Enemy

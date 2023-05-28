extends Planes
class_name Enemy

@onready var sprite = $sprite
	
func handle_hit(col):
	if col is Bullet or col is Player:
		crash_plane()

func _get_class():
	return Enemy

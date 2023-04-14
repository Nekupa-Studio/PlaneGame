extends CustomCharacter
class_name Enemy

@onready var sprite = $sprite

func _process(delta):
	Elevation.update(self)

func _get_class():
	return Enemy

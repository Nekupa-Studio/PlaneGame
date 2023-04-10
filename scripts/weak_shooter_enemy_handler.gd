extends CharacterBody2D
class_name Enemy

@onready var sprite = $sprite

func _ready():
	add_child(Shadow.create_shadow(sprite))
	
func _on_hitbox_area_entered(area):
	var col = area.get_parent()
	
	if not col.has_method("_get_class"):
		# Maybe think about a better way to, yknow, handle this
		print("Collision with non-custom class")
		return
	
	match col._get_class():
		Player:
			queue_free()
		Bullet:
			# TODO: Might add here an ability for bullet to not be deleted after first hit
			# Something like : col.hit() -> hit_left - 1 and if hit_left == 0, then queue_free()
			queue_free()

# Override get_class() function cuz it doesn't normally return custom classes.
func _get_class():
	return Enemy

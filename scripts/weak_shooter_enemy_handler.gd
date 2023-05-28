extends CustomCharacter
class_name Enemy

@onready var sprite = $sprite

func crash_plane():
	var explosion = load("res://assets/explosion_emitter.tscn")
	var particles = explosion.instantiate()
	particles.position = position
	get_tree().root.add_child(particles)
	particles.emitting = true
	particles.connect("property_list_changed", particles.queue_free)
	
	queue_free()
	
func handle_hit(col):
	if col is Bullet or col is Player:
		var death_tween = create_tween()
		death_tween.tween_property(self, "elevation", 0, (elevation/25) * 0.1)
		death_tween.connect("finished", crash_plane)

func _get_class():
	return Enemy

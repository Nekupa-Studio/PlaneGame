extends CustomCharacter
class_name Planes

var explosion: PackedScene = preload("res://assets/explosion_emitter.tscn")

func crash_plane():
	var death_tween = create_tween()
	death_tween.tween_property(self, "elevation", 0, (elevation/25) * 0.1)
	await death_tween.finished
		
	var particles = explosion.instantiate()
	particles.position = position
	
	get_tree().root.add_child(particles)
	
	particles.emitting = true
	particles.connect("property_list_changed", particles.queue_free)
	
	queue_free()

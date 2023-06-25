extends CustomCharacter
class_name Planes

var explosion: PackedScene = preload("res://assets/explosion_emitter.tscn")
var fire: PackedScene = preload("res://assets/fire_particles.tscn")

func crash_plane(crash_speed_mult = 1):
	var fire_particles = fire.instantiate()
	fire_particles.position = Vector2(0,0)
	fire_particles.direction = Vector2(0, -sign(velocity.y))
	add_child(fire_particles) 
	
	var death_tween = create_tween()
	death_tween.tween_property(self, "elevation", 0, (elevation/25) * 0.1 * crash_speed_mult)
	await death_tween.finished
		
	var exp_particles = explosion.instantiate()
	exp_particles.position = position
	
	get_tree().root.add_child(exp_particles)
	
	exp_particles.emitting = true
	exp_particles.connect("property_list_changed", exp_particles.queue_free)
	
	queue_free()
	

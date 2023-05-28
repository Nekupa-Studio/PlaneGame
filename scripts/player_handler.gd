extends Planes
class_name Player

const BULLET_SCENE = preload("res://assets/bullet.tscn")
const ELEV_LERP_FACTOR = 0.12

@export var speed := 225
@export var attack_cooldown := 0.2

@onready var sprite := $Sprite
@onready var shoot_particle_system := $shoot_particle

var friction: float = 0.08
var attack_time: float = 0
var gun_firing: int = 0
var particle_systems: Array[CPUParticles2D]

func _physics_process(delta):
	super(delta)
	
	# Shooting system
	attack_time += delta
	if Input.is_action_pressed("shoot") and attack_time > attack_cooldown:
		shoot()
		attack_time = 0
	
	move()

func shoot():
	var bullet = BULLET_SCENE.instantiate()
	
	bullet.direction = Vector2(0,-1)
	bullet.speed = 350
	
	gun_firing = (gun_firing+1)%2
	var bullet_pos = [$Gun1.global_position, $Gun2.global_position][gun_firing]
	bullet.position = bullet_pos
	bullet.creator = self
	bullet.elevation = elevation
	bullet.top_level = true
	
	# Code related to the firing particles
	var shoot_particle = shoot_particle_system.duplicate()
	shoot_particle.position = to_local(bullet_pos)
	add_child(shoot_particle)
	shoot_particle.emitting = true
	shoot_particle.connect("property_list_changed", shoot_particle.queue_free)
	
	add_child(bullet)

func handle_hit(col):
	if col is Enemy:
		crash_plane()

# Moving the player
func move():
	# Changing velocity according to user's inputs.
	# lerp(from, to, % of change) -> used to interpolate values.
	velocity.x = lerp(velocity.x, Input.get_axis("left", "right") * speed, friction)
	velocity.y = lerp(velocity.y, Input.get_axis("up", "down") * speed, friction)
	
	# Elevation system, elev_target -> [0,100]
	var elev_target = ((Input.get_axis("descent", "elevate")+1)/2) * 100
	elevation = lerp(elevation, elev_target, ELEV_LERP_FACTOR)
	
	move_and_slide()

func _get_class():
	return Player

extends CharacterBody2D
class_name Player # On nomme la classe afin de pouvoir noter : if [thingie] is Player:

const BULLET_SCENE = preload("res://assets/bullet.tscn")

# Variables de type "export", accessibles dans l'inspecteur
@export var speed := 225
@export var attack_cooldown := 0.2

# Variables de type "onready", s'initialisent seulement lorsque scène prête.
@onready var sprite := $Sprite
@onready var shoot_particle_system := $shoot_particle

# Variables accessibles dans tout le script
var friction: float = 0.08 # valeur entre 0 et 1 équivalent d'un %
var shadow: AnimatedSprite2D
var attack_time: float = 0
var gun_firing: int = 0
var particle_systems: Array[CPUParticles2D]
var elevation: float = 50 # Goes from 1-100, if you go down too much: KABOOM

func _ready():
	# Création de l'ombre
	shadow = Shadow.create_shadow(sprite)
	add_child(shadow)

# Fonction appelée à chaque frame
func _physics_process(delta):
	# Incrémente la variable de temps par 1/60
	attack_time += delta
	
	move()
	
	# Gère le pew pew
	if Input.is_action_pressed("shoot") and attack_time > attack_cooldown:
		shoot()
		attack_time = 0

func _process(delta):
	elevation_update()

func elevation_update():
	# Met à jour l'ombre, la taille et le z_index de l'object en fonction de l'élévation
	shadow.position = Shadow.SHADOW_OFFSET * ((elevation/100) + 0.5)
	scale = Vector2(1,1) * ((elevation/100) + 0.5)
	z_index = elevation

func shoot():
	var gun_positions = [$Gun1.global_position, $Gun2.global_position]
	var bullet = BULLET_SCENE.instantiate()
	
	bullet.direction = Vector2(0,-1)
	bullet.speed = 350
	
	gun_firing = (gun_firing+1)%2
	var bullet_pos = [$Gun1.global_position, $Gun2.global_position][gun_firing]
	bullet.position = bullet_pos
	bullet.scale = scale
	bullet.top_level = true
	bullet.elevation = elevation
	bullet.z_index = elevation
	
	# Code related to the firing particles
	var shoot_particle = shoot_particle_system.duplicate()
	shoot_particle.position = to_local(bullet_pos)
	add_child(shoot_particle)
	shoot_particle.emitting = true
	shoot_particle.connect("property_list_changed", shoot_particle.queue_free)
	
	add_child(bullet)

# Fonction dédiée au mouvement
func move():
	# Récupération des entrées du joueur pour connaitre la direction du joueur
	# lerp(from, to, % of change) -> sert à interpoler des valeurs.
	velocity.x = lerp(velocity.x, Input.get_axis("left", "right") * speed, friction)
	velocity.y = lerp(velocity.y, Input.get_axis("up", "down") * speed, friction)
	
	# Système d'élévation, elev_in -> [0,100]
	var elev_in = ((Input.get_axis("descent", "elevate")+1)/2) * 100
	elevation = lerp(elevation, elev_in, friction)
	
	move_and_slide()

# Fonction qui, lorsque que le signal d'une collision est reçu, est activée.
func _on_hitbox_entered(area):
	var col = area.get_parent()
	if col is Enemy and abs(elevation - col.elevation) < 5:
		queue_free()
	
# Override get_class() function cuz it doesn't normally return custom classes.
func _get_class():
	return Player

extends CharacterBody2D
class_name Player # On nomme la classe afin de pouvoir noter : if [thingie] is Player:

# Variables de type "export", accessibles dans l'inspecteur
@export var speed := 225

# Variables de type "onready", s'initialisent seulement lorsque scène prête.
@onready var sprite := $Sprite

# Variables accessibles dans tout le script
var friction = 0.08 # valeur entre 0 et 1 équivalent d'un %
var shadow: Sprite2D 

# Fonction appelée à chaque frame

func _ready():
	var shadow = Shadow.create_shadow(sprite)
	add_child(shadow)
	pass

func _physics_process(delta):
	move()

func _process(delta):
	pass

# Fonction dédiée au mouvement
func move():
	# Récupération des entrées du joueur pour connaitre la direction du joueur
	# lerp(from, to, % of change) -> sert à interpoler des valeurs.
	velocity.x = lerp(velocity.x, Input.get_axis("left", "right") * speed, friction)
	velocity.y = lerp(velocity.y, Input.get_axis("up", "down") * speed, friction)
	
	move_and_slide()

# Fonction qui, lorsque que le signal d'une collision est reçu, est activée.
func _on_hitbox_entered(area):
	pass # On y touche pas pour l'instant

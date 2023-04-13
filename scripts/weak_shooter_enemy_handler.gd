extends CharacterBody2D
class_name Enemy

@onready var sprite = $sprite

@export_range(0,100) var elevation: float = 50

var shadow

func _ready():
	shadow = Shadow.create_shadow(sprite)
	add_child(shadow)
	
func _on_hitbox_area_entered(area):
	var col = area.get_parent()
	
	if not col.has_method("_get_class"):
		# Maybe think about a better way to, yknow, handle this
		print("Collision with non-custom class")
		return
	
	# yea imma need to do something better
	if abs(elevation - col.elevation) > 5:
		return
	
	match col._get_class():
		Player:
			queue_free()
		Bullet:
			# TODO: Might add here an ability for bullet to not be deleted after first hit
			# Something like : col.hit() -> hit_left - 1 and if hit_left == 0, then queue_free()
			queue_free()

func _process(delta):
	elevation_update()

func elevation_update():
	# Met à jour l'ombre, la taille et le z_index de l'object en fonction de l'élévation
	shadow.position = Shadow.SHADOW_OFFSET * ((elevation/100) + 0.5)
	scale = Vector2(1,1) * ((elevation/100) + 0.5)
	z_index = elevation

# Override get_class() function cuz it doesn't normally return custom classes.
func _get_class():
	return Enemy

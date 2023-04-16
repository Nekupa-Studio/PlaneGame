extends CharacterBody2D
class_name CustomCharacter

@export_range(0,100) var elevation: float = 50

var creator: Object
var hitbox: Area2D
var shadow

func _ready():
	for child in get_children():
		if child is AnimatedSprite2D or child is Sprite2D:
			shadow = Shadow.create_shadow(child)
			add_child(shadow)
		elif child is Area2D:
			hitbox = child

func _physics_process(delta):
	for hit in hitbox.get_overlapping_areas():
		var col = hit.get_parent()
		handle_collision(col)

func handle_collision(col):
	var is_custom_class = col is CustomCharacter
	var is_creation = col.creator == self
	var is_creator = col == self.creator
	var is_same_level = Elevation.check_state(col, self)
	
	if is_custom_class and not (is_creation or is_creator) and is_same_level:
		handle_hit(col)

func _process(delta):
	Elevation.update(self)

func handle_hit(_col):
	print("'handle_hit' function seems to not have been overwritten in object: ", name, " please report to dev!")

func _get_class():
	return CustomCharacter

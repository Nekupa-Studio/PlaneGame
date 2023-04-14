extends CharacterBody2D
class_name CustomCharacter

@export_range(0,100) var elevation: float = 50

var creator: Object
var shadow

func _ready():
	for child in get_children():
		if child is AnimatedSprite2D or child is Sprite2D:
			shadow = Shadow.create_shadow(child)
			add_child(shadow)

func _on_hitbox_area_entered(area):
	var col = area.get_parent()

	var is_custom_class = col is CustomCharacter
	var is_creation = col.creator == self
	var is_creator = col == self.creator
	var is_same_level = Elevation.check_state(self, col)
	
	if is_custom_class and not (is_creation or is_creator) and is_same_level:
		col.handle_hit()

func _process(delta):
	Elevation.update(self)

func handle_hit():
	print("this function seems to not have been overwritten in object: ", name, " please report to dev!")

func _get_class():
	return CustomCharacter

extends Camera2D
class_name RollingCamera

@export var followed: CustomCharacter
var following: bool = true
var camera_half_height: int

# Connecting signal, so that when player is deleted, the game doesn't crash
func _ready():
	followed.connect("tree_exiting", func():following=false)
	camera_half_height = get_viewport_rect().size.y/(2*zoom.y)
	

# Following the character according to y coord.
func _physics_process(delta):
	if following:
		position.y = followed.position.y - camera_half_height
	


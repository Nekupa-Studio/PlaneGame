extends StaticBody2D
class_name Base

signal health_changed(max_health,health)
signal game_over()

@onready var hitbox = $hitbox

const MAX_HEALTH: float = 10

var health: float = 10

func _ready():
	hitbox.connect("area_entered", handle_col)
	
func handle_col(hit):
	var col = hit.get_parent()
	
	if col is Enemy:
		health -= 1 
		col.crash_plane(0)
		col.hitbox.disable_mode = true
		emit_signal("health_changed", MAX_HEALTH, health)
		
	if health < 0:
		get_tree().reload_current_scene()

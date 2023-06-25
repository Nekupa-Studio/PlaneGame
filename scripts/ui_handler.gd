extends CanvasLayer
class_name UI

@onready var health_bar = $main_control/healthbg/healthfill

var initial_health_width: int

func _ready():
	initial_health_width = health_bar.size.x
	
func update_health(max_health, health):
	health_bar.size.x = initial_health_width * (health/max_health)

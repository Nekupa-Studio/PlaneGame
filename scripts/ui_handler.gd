extends CanvasLayer
class_name UI

@onready var health_bar = $main_control/healthbg/healthfill
@onready var gear_amount = $gear_amount/RichTextLabel

var initial_health_width: int

func _ready():
	initial_health_width = health_bar.size.x
	gear_amount.text = "0"
	
func update_health(max_health, health):
	health_bar.size.x = initial_health_width * (health/max_health)

func update_gears(gears):
	gear_amount.text = str(gears)

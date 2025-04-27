extends GameActor
class_name Enemy

@export var shoot_system: ShootingSystem

@export var speed: float = 60

func _ready() -> void:
	assert(shoot_system, "Shoot system not initialized for Enemy at %s" % get_path())

func _physics_process(_delta: float) -> void:
	
	shoot_system.fire()

	velocity.y = speed
	
	move_and_slide()

extends GameActor
class_name Player

@export var speed: float = 200.0

@export var friction_kup: float = 0.1
@export var friction_kdown: float = 0.8

@export var shoot_system: ShootingSystem

func move() -> void:
	
	var direction := Vector2 (
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)
	
	var friction: float = friction_kdown if direction else friction_kup
	
	velocity = lerp(velocity, direction.normalized() * speed, friction)

	move_and_slide()

func _ready() -> void:
	assert(shoot_system, "Player ShootingSystem wasn't initialized at %s." % get_path())
	
func _physics_process(_delta: float) -> void:
	
	move()
	
	if Input.is_action_pressed("shoot"):
		
		shoot_system.fire()

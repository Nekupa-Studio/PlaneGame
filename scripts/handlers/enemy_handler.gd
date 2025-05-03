extends GameActor
class_name Enemy

enum STATES {IDLE, FIRING}

@export var shoot_system: ShootingSystem
@export var reaction_time: float = 0.15
@export var shoot_stop_time: float = 0.6
@export var speed: float = 60

var time_since_change: float = INF

var current_state := STATES.IDLE

func move():
	velocity.y = speed
	
	move_and_slide()
	
func idle_behavior():
	if time_since_change >= shoot_stop_time: return
	shoot_system.fire()
	
func firing_behavior():
	if time_since_change < reaction_time: return
	shoot_system.fire()

func change_state(new_state: STATES):
	assert(new_state in STATES.values(), "Invalid state change at %s" % get_path())
	current_state = new_state
	time_since_change = 0

func _ready() -> void:
	assert(shoot_system, "Shoot system not initialized for Enemy at %s" % get_path())
	$Hitbox.add_to_group(GameConfig.TARGETABLE_GROUP)
	
func _physics_process(delta: float) -> void:
	
	match current_state:
		STATES.FIRING: firing_behavior()
		STATES.IDLE: idle_behavior()
			
	time_since_change += delta

	move()

func on_enemy_lost(enemy: GameActor) -> void:
	if not enemy is Player: return
	change_state(STATES.IDLE)

func on_enemy_in_sight(enemy: GameActor) -> void:
	if not enemy is Player: return
	change_state(STATES.FIRING)
	

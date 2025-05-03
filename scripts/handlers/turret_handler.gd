class_name BaseTurret
extends GameActor

enum STATES {SCANNING, LOCKED}

var current_state := STATES.SCANNING

@export var shooting_system: ShootingSystem
@export var target_min_distance: float = 30

@export_category("🔁 Rotation Parameters")
@export var rot_per_second: float = 0.5
@export var rot_off_time: float = 0.3
@export_range(0,180,1) var rot_range: float = 180

var target: GameActor

var rotating: bool = true
var rot_dir: int = 1

var up_angle: float = 270
var time_since_rot_stop: float = 0

@onready var max_angle: float = up_angle + rot_range / 2
@onready var min_angle: float = up_angle - rot_range / 2
@onready var rot_speed: float = deg_to_rad(rot_range * rot_per_second)

func locked_behavior(_delta: float):
	if not target:
		current_state = STATES.SCANNING
		return
	
	look_at(target.global_position)
	shooting_system.fire()
	
	var target_distance = target.global_position.distance_to(global_position)
	
	if is_angle_out_of_bounds() or target_distance <= target_min_distance:
		current_state = STATES.SCANNING
		target = null
		return
	
func inverting_rotation(delta: float):
	
	if time_since_rot_stop >= rot_off_time:
		rotating = true
		
	time_since_rot_stop += delta
	
func scanning_by_rotating(delta: float):
	
	rotate(rot_speed * delta * rot_dir)
	
	if is_angle_out_of_bounds():
		rotating = false
		time_since_rot_stop = 0
		
		rotation_degrees = max_angle if rot_dir == 1 else min_angle
		
		rot_dir *= -1
	
func scanning_behavior(delta: float):
	
	if rotating:
		scanning_by_rotating(delta)
		return
	inverting_rotation(delta)
	
func is_angle_out_of_bounds():
	return rotation_degrees >= max_angle or rotation_degrees <= min_angle
	
func _ready() -> void:
	assert(shooting_system, "No ShootingSystem assigned to Turret at %s" % get_path())
	rotation_degrees = up_angle
	
func _physics_process(delta: float) -> void:
	
	match current_state:
		STATES.LOCKED: locked_behavior(delta)
		STATES.SCANNING: scanning_behavior(delta)

func _on_vision_system_enemy_detected(enemy: GameActor) -> void:
	
	var target_distance = enemy.global_position.distance_to(global_position)
	var is_target_far_enough = target_distance >= target_min_distance
	
	if current_state == STATES.SCANNING and is_target_far_enough:
		current_state = STATES.LOCKED
		target = enemy

func _on_vision_system_enemy_lost(enemy: GameActor) -> void:
	if current_state == STATES.LOCKED:
		current_state = STATES.SCANNING
		if target == enemy: 
			target = null

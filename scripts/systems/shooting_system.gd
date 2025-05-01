@icon("res://imports/editor_icons/skull.png")
extends Node2D
class_name ShootingSystem

enum ERR_FLAGS {
	SHOOT_OFF = 0b0001,
	COOLING_DOWN = 0b0010
}

signal shooting_failed(reason: int)

const bullet_scene: PackedScene = GameConfig.BULLET_SCENE

@export var toggled: bool = true
@export var bullet_data: BulletResource
@export var firing_points: Array[FiringPoint]

@onready var fpoint_amount: int = len(firing_points)

var parent: GameActor

var fire_idx: int = 0
var f_down_time: float = INF

func _ready() -> void:
	assert(not firing_points.is_empty(), "No firing points in ShootingSystem at %s" % get_path)
	
	parent = get_parent()
	var err_data = [parent.name, name]
	assert(parent is GameActor, "Invalid parent %s for ShootingSystem at %s" % err_data)

func _physics_process(delta: float) -> void:
	f_down_time += delta
	
func fire() -> void:
	if not toggled: 
		emit_signal("shooting_failed", ERR_FLAGS.SHOOT_OFF)
		return
	
	if f_down_time < bullet_data.cooldown: 
		emit_signal("shooting_failed", ERR_FLAGS.COOLING_DOWN)
		return
	
	match bullet_data.firing_mode:
		
		BulletResource.FIRING_TYPES.SINGLE:		
			var fire_point = firing_points[fire_idx]
			create_bullet(fire_point.global_position, fire_point.direction)
			
			fire_idx = (fire_idx + 1) % fpoint_amount
			
		BulletResource.FIRING_TYPES.SIMULTANEOUS:
			for point in firing_points:
				create_bullet(point.global_position, point.direction)
	
	f_down_time = 0
	
func create_bullet(bullet_pos: Vector2, bullet_dir: Vector2) -> void:
	var bullet = bullet_scene.instantiate()
	bullet.actor_type = parent.actor_type
	bullet.data = bullet_data
	bullet.direction = bullet_dir.normalized()
	bullet.global_position = bullet_pos
	bullet.z_index = GameConfig.BULLET_LAYER
	get_tree().current_scene.add_child(bullet)
	
	

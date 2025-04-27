extends Node2D
class_name ShootingSystem

signal shooting_failed

const bullet_scene: PackedScene = preload("res://assets/bullet.tscn")

@export var toggled: bool = true
@export var bullet_data: BulletResource
@export var firing_points: Array[Node2D]

@export var direction := Vector2(0,-1)

@onready var fpoint_amount: int = len(firing_points)

var parent: CharacterBody2D

var fire_idx: int = 0
var f_down_time: float = INF

func _ready() -> void:
	parent = get_parent()
	
	var err_data = [parent.name, name]
	assert(parent is CharacterBody2D, "Invalid parent %s for %s" % err_data)

func _physics_process(delta: float) -> void:
	f_down_time += delta
	
func fire() -> void:
	if not toggled: 
		emit_signal("shooting_failed", 1)
		return
	
	if f_down_time < bullet_data.cooldown: 
		emit_signal("shooting_failed", 2)
		return
	
	match bullet_data.firing_mode:
		
		BulletResource.FIRING_TYPES.SINGLE:		
			var bullet_pos = firing_points[fire_idx].global_position
			create_bullet(bullet_pos)
			fire_idx = (fire_idx + 1) % fpoint_amount
			
		BulletResource.FIRING_TYPES.SIMULTANEOUS:
			for point in firing_points:
				create_bullet(point.global_position)
	
	f_down_time = 0
	
func create_bullet(bullet_pos: Vector2) -> void:
	var bullet = bullet_scene.instantiate()
	bullet.creator = parent
	bullet.data = bullet_data
	bullet.direction = direction.normalized()
	bullet.global_position = bullet_pos
	bullet.z_index = GameConfig.BULLET_LAYER
	get_tree().current_scene.add_child(bullet)
	
	

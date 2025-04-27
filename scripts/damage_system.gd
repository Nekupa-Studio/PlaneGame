extends Node2D
class_name DamageSystem

signal hit(health: float, raw_damage: float, final_damage: float)
signal barrier_broke()
signal destroyed()

@export var plane_data: PlaneResource
@export var hitbox: Area2D

@export var enemy_type := GameActor.ACTOR_TYPES.PLAYER

var health: float = 0
var barrier: float = 0

func _ready():
	assert(plane_data, "No plane data given for DamageSystem at %s" % get_path())
	assert(plane_data.health, "No plane initial health for DamageSystem at %s" % get_path())
	assert(hitbox, "No hitbox initialized for DamageSystem at %s" % get_path())
	
	health = plane_data.health
	barrier = plane_data.barrier

	hitbox.connect("area_entered", handle_collision)

func handle_collision(area: Area2D) -> void:
	var col := area.get_parent()
	
	if col is Bullet and col.actor_type == enemy_type:
		calculate_damage(col.data.damage)

func calculate_damage(damage):
	var inc_damage = damage
		
	if barrier > 0:
		var new_barrier = barrier - inc_damage
		inc_damage = 0 if new_barrier >= 0 else abs(new_barrier)
		if new_barrier <= 0: emit_signal("barrier_broke")
		barrier = max(new_barrier, 0)
	
	var final_damage = max(GameConfig.MIN_DAMAGE, inc_damage - plane_data.armor)
	health = max(0, health - final_damage)
	
	print("%s took damage" %get_parent().name)
	
	if health <= 0:
		emit_signal("destroyed")
		return
	
	emit_signal("hit", health, damage, final_damage)

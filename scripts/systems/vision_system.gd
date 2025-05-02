@icon("res://imports/editor_icons/eye.png")
extends Node2D
class_name VisionSystem

const ENTERING = true
const LEAVING = false

signal enemy_detected(enemy: GameActor)
signal enemy_lost(enemy: GameActor)

@export var sight_area: SightZone
@export var target_mask := GameActor.ACTOR_TYPES.PLAYER

func seeking_behavior(col: GameActor) -> void:
	var is_target = col is GameActor and col.actor_type == target_mask
	if not is_target: return
	
	emit_signal("enemy_detected", col)
	
func locked_behavior(col: GameActor) -> void:
	emit_signal("enemy_lost", col)

func handle_area(area, entering):
	var col = area.get_parent()
	var is_target = (
		col is GameActor and
		col.actor_type == target_mask and
		not area is SightZone
	)
	
	if not is_target: return
	
	if entering: seeking_behavior(col)
	else: locked_behavior(col)

func _ready() -> void:
	assert(sight_area, "No line of sight for VisionSystem at %s" % get_path())
	
	sight_area.connect("area_entered", func(col): handle_area(col, ENTERING))
	sight_area.connect("area_exited", func(col): handle_area(col, LEAVING))

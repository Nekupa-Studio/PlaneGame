@tool
@icon("res://imports/editor_icons/cursor.png")
extends Node2D
class_name FiringPoint

@export_range(0, 360, 1) var angle: float = 90:
	set = _on_angle_changed
	
var direction: Vector2 : get = get_fire_direction

@onready var parent: GameActor = get_parent()

func _ready() -> void:
	var err_mess := "Invalid parent for FiringPoint at %s (should be GameActor)" % get_path()
	assert(parent is GameActor, err_mess)

func get_fire_direction() -> Vector2:

	var final_angle: float = deg_to_rad(-angle)
	
	final_angle += parent.rotation if not Engine.is_editor_hint() else 0.0
	
	var dir = Vector2.from_angle(final_angle)
	return dir
	
func _on_angle_changed(new: float) -> void:
	angle = new
	queue_redraw()
	
func _draw() -> void:
	if not Engine.is_editor_hint():
		var can_draw := GameConfig.FP_DEBUG_DIRECTION and OS.is_debug_build()
		if not can_draw: return
	
	var dir = get_fire_direction() * GameConfig.FP_TOOL_RANGE
	
	DrawUtils.draw_arrow(self, Vector2.ZERO, dir, Color.RED)

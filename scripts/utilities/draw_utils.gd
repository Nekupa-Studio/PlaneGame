class_name DrawUtils

## Used for draw_arrow() method. 
static func get_arrowhead(dir: Vector2) -> Array:
	return [
		dir + dir.rotated(-90).normalized(),
		dir + dir.rotated(90).normalized(),
		dir + dir.normalized()
	]

## Static method used to draw arrows for debug-purpose mainly.
## Can only be called in _draw().
static func draw_arrow(target: Node2D, pos: Vector2, dir: Vector2, col: Color) -> void:
	
	target.draw_line(pos, dir, col)
	target.draw_polygon(get_arrowhead(dir), [col])

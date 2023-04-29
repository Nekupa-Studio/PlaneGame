extends Node2D
class_name PlaneSpawner

@export var PLANE_TYPE: PackedScene = load("res://assets/enemy.tscn")
@export var SPAWN_AMOUNT: int = 5
@export var SPAWN_INTERVAL: float = 1.5
@export var ELEVATION_LEVEL: Elevation.ELEVATION_STATES

#var PATH: Path2D

var spawn_cd: float = 0
var spawned: int = 0

"""
func _ready():
	for child in get_children():
		if child is Path2D:
			PATH = child
			break
"""

func _physics_process(delta):
	spawn_cd += delta
	
	if spawn_cd >= SPAWN_INTERVAL and not spawned >= SPAWN_AMOUNT:
		var plane: Enemy = PLANE_TYPE.instantiate()
		plane.top_level = true
		plane.position = position
		plane.elevation = Elevation.get_elev_from_state(ELEVATION_LEVEL)
		
		add_child(plane)
		
		spawn_cd = 0 
		spawned += 1

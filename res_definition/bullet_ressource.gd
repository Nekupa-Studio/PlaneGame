extends Resource
class_name BulletResource

enum FIRING_TYPES {SINGLE, SIMULTANEOUS}

@export var damage: float = 1 
@export var speed: float = 100
@export var bullet_range: float = 100

@export var firing_mode: FIRING_TYPES
@export var cooldown: float = 0.3

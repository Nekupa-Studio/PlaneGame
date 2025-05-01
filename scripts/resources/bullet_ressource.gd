extends Resource
class_name BulletResource

enum FIRING_TYPES {
	## Only one guns shoots at a time.
	SINGLE,
	## All guns shoot at the same time.
	SIMULTANEOUS
}

## Color of the bullet.
@export var modulate: Color = Color.DARK_ORANGE

## Damage dealt by the bullet.
@export var damage: float = 1

## Speed of the bullet. 
@export var speed: float = 100

## How many enemies can bullet go through
@export var piercing_power: int = 1

## Max traveled distance by bullet. Used to determine its lifetime.
@export var bullet_range: float = 100

## Firing mode of the bullet.
@export var firing_mode: FIRING_TYPES

## Cooldown between shots.
@export var cooldown: float = 0.3

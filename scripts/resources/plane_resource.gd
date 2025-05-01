extends Resource
class_name PlaneResource

## Life of the plane. 0 is death.
@export var health: float = 1.0 

## Armor of the plane. It is substracted from incoming damages with a
## minimum damage of one.
@export var armor: float = 0.0

## Barrier of the plane. It will tank damage without any impact on health
## until it runs out.
@export var barrier: float = 0.0

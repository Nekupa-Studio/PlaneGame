extends CharacterBody2D
class_name Bullet

var creator: Node2D 
var data: BulletResource
var direction: Vector2

var lifetime: float
var lived: float

func _ready() -> void:
	assert(creator, "No creator specified for Bullet %s." % name)
	assert(data, "No data specified for Bullet %s." % name)
	assert(direction, "No direction specified for Bullet %s." % name)
	
	lifetime = data.bullet_range / data.speed
	
func _physics_process(delta: float) -> void:
	
	if lived >= lifetime:
		self.call_deferred("queue_free")
	
	velocity = direction * data.speed
	
	lived += delta
	
	move_and_slide()

extends GameActor
class_name Bullet

var data: BulletResource
var direction: Vector2

var lifetime: float
var lived: float

func _ready() -> void:
	assert(actor_type, "No creator specified for Bullet at %s." % get_path())
	assert(data, "No data specified for Bullet at %s." % get_path())
	assert(direction, "No direction specified for Bullet at %s." % get_path())
	
	modulate = data.modulate
	
	lifetime = data.bullet_range / data.speed
	
func _physics_process(delta: float) -> void:
	
	if lived >= lifetime:
		self.call_deferred("queue_free")
	
	velocity = direction * data.speed
	
	lived += delta
	
	move_and_slide()

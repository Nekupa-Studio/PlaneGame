class_name BaseTurret
extends GameActor

var shooting = false

func _physics_process(delta: float) -> void:
	rotate(delta * PI / 2)
	
	if shooting:
		$ShootingSystem.fire()


func _on_vision_system_enemy_detected(enemy: GameActor) -> void:
	shooting = true

func _on_vision_system_enemy_lost(enemy: GameActor) -> void:
	shooting = false

extends Node

func _ready() -> void:
	if not OS.is_debug_build():
		queue_free()

func _physics_process(_delta: float) -> void:
	if not OS.is_debug_build(): return
	
	if Input.is_action_just_pressed("DEBUG_RELOAD"):
		get_tree().reload_current_scene()

class_name Elevation

const STATE_HEIGHT = 25

enum ELEVATION_STATES {
	HIGH = 3,
	MIDDLE = 2,
	LOW = 1
}

static func update(obj: CustomCharacter):
	var elevation = obj.elevation
	# Met à jour l'ombre, la taille et le z_index de l'object en fonction de l'élévation
	obj.shadow.position = Shadow.SHADOW_OFFSET * ((elevation/100) + 0.5)
	obj.scale = Vector2(1,1) * ((elevation/100) + 0.5)
	obj.z_index = elevation

static func get_elev_state(obj: CustomCharacter):
	for state in ELEVATION_STATES:
		if obj.elevation >= (ELEVATION_STATES[state] * STATE_HEIGHT) - 1:
			return state

static func check_state(obj1: CustomCharacter, obj2: CustomCharacter):
	return get_elev_state(obj1) == get_elev_state(obj2)

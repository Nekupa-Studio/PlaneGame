class_name Elevation

const STATE_HEIGHT = 25

enum ELEVATION_STATES {
	HIGH = 3,
	MIDDLE = 2,
	LOW = 1
}

# Updates obj's properties linked to elevation
static func update(obj: CustomCharacter):
	var elevation = obj.elevation
	obj.shadow.position = Shadow.SHADOW_OFFSET * ((elevation/100) + 0.5)
	obj.scale = Vector2(1,1) * ((elevation/100) + 0.5)
	obj.z_index = elevation

# Get obj's elevation state from its elevation
static func get_elev_state(obj: CustomCharacter):
	for state in ELEVATION_STATES:
		if obj.elevation >= (ELEVATION_STATES[state] * STATE_HEIGHT) - 1:
			return state

# This function gets the typical elevation given the state of an object.
static func get_elev_from_state(state: ELEVATION_STATES):
	#LOW -> 0 // MIDDLE -> 50 // HIGH -> 100
	return (state - 1) * (2 * STATE_HEIGHT)

static func check_state(obj1: CustomCharacter, obj2: CustomCharacter):
	return get_elev_state(obj1) == get_elev_state(obj2)

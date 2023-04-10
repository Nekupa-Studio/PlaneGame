extends Node
class_name Shadow

const SHADOW_OFFSET := Vector2(20, 20)
const SHADOW_TRANSPARENCY := 0.3

static func create_shadow(sprite: Object):
	assert (sprite is Sprite2D or sprite is AnimatedSprite2D)
	var shadow_sprite = sprite.duplicate()
	shadow_sprite.z_index = sprite.z_index - 1 # Show the shadow behind the sprite
	shadow_sprite.self_modulate = Color(0, 0, 0, SHADOW_TRANSPARENCY)
	shadow_sprite.position = SHADOW_OFFSET
	return shadow_sprite

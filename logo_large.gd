extends Node2D
enum Offset_modes {TOP_LEFT, TOP_CENTER, TOP_RIGHT, CENTER_LEFT, CENTER, CENTER_RIGHT, BOTTOM_LEFT, BOTTOM_CENTER, BOTTOM_RIGHT}

@export var texture: Texture2D

func get_rotation_x() -> float:
	return $TextureRect.material.get_shader_parameter("x_rot")

func set_rotation_x(angle: float) -> void:
	$TextureRect.material.set_shader_parameter("x_rot", angle)

func rotate_x(interval: float) -> void:
	var original_angle = get_rotation_x()
	var tween = get_tree().create_tween()
	tween.tween_method(set_rotation_x, original_angle, rad_to_deg(TAU), interval)
	tween.tween_method(set_rotation_x, get_rotation_x(), rad_to_deg(TAU), interval)

func _process(delta: float) -> void:
	$TextureRect.texture = texture
	pass

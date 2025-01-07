extends Node2D

@onready var texture: TextureRect = $TextureRect
@onready var path_follow_2d: PathFollow2D = $"../Paths/Elipsis/PathFollow2D"

### Helper function to get the X rotation angle (in degrees) in the transformation shader.
func get_rotation_x() -> float:
	return $TextureRect.material.get_shader_parameter("x_rot")

### Helper function to write an angle (in degrees) to the X rotation parameter in the transformation shader. 
func set_rotation_x(angle: float) -> void:
	$TextureRect.material.set_shader_parameter("x_rot", angle)

### Helper function to get the Y rotation angle (in degrees) in the transformation shader.
func get_rotation_y() -> float:
	return $TextureRect.material.get_shader_parameter("y_rot")

### Helper function to write an angle (in degrees) to the Y rotation parameter in the transformation shader. 
func set_rotation_y(angle: float) -> void:
	$TextureRect.material.set_shader_parameter("y_rot", angle)

### Flips a texture on the X axis
func rotate_x(interval: float) -> void:
	var original_angle = get_rotation_x()
	var tween = get_tree().create_tween()
	tween.tween_method(set_rotation_x, original_angle, rad_to_deg(TAU), interval)
	tween.tween_method(set_rotation_x, get_rotation_x(), rad_to_deg(TAU), interval)

### Flips a texture on the Y axis
func rotate_y(interval: float) -> void:
	var original_angle = get_rotation_y()
	var tween = get_tree().create_tween()
	tween.tween_method(set_rotation_y, original_angle, rad_to_deg(TAU), interval)
	tween.tween_method(set_rotation_y, get_rotation_y(), rad_to_deg(TAU), interval)

### Transforms a texture to resemble one of the fragments of an X shape.
func cross_rotate(interval: float) -> void:
	# rotate_x, rotate_y and rotate the whole texture at 45 degrees (.78 rad)
	# the rads are there because of some funny glitches if I worked with degrees(????)
	var original_angle_x = get_rotation_x()
	var original_angle_y = get_rotation_y()
	var original_angle = $TextureRect.rotation
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_method(set_rotation_x, original_angle_x, rad_to_deg(TAU), interval)
	tween.tween_method(set_rotation_y, original_angle_y, rad_to_deg(TAU), interval)
	#tween.tween_property($TextureRect, "rotation", TAU, interval)

func rotate_following_path(path: PathFollow2D, interval: float) -> void:
	var tween = get_tree().create_tween()
	var original_angle_x = get_rotation_x()
	tween.tween_method(set_rotation_x, original_angle_x, rad_to_deg(TAU), interval)
	texture.position = path.position

## Given a path to follow, update the position of this Node in relation to the path's progress, at a given speed.
## WARN: Must be run in _process().
func move_alongside_path(progress_ratio: float, path_follow: PathFollow2D) -> void:
	path_follow.progress += progress_ratio * get_process_delta_time()

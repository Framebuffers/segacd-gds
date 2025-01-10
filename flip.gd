class_name card extends Node2D

# based on https://godotshaders.com/shader/2d-perspective/
# and https://simonhartcher.com/3d-look-rotations-in-2d-with-godot-4
#
# structure: 
# Node2D (add script here)
# |-> TextureRect
#		|-> (on the editor) CanvasItem -> Material (put the shader here)

const SHADER_X_ROTATION = "x_rot"
const SHADER_Y_ROTATION = "y_rot"

@export var texture: TextureRect

# rotation X
var rotation_tween_x: Tween
var speedup_ratio_x = 1.0
var speed_x = 1.0:
	set = set_speed_x

func set_speed_x(new_speed_x: float) -> void:
	speed_x = new_speed_x
	speed_up_x(new_speed_x)
	pass
	
func speed_up_x(_value) -> void:
	rotation_tween_x.set_speed_scale(1.0/_value)
	pass

# rotation Y
var rotation_tween_y: Tween
var speedup_ratio_y = 1.0
var speed_y = 1.0:
	set = set_speed_y

func set_speed_y(new_speed_y: float) -> void:
	speed_y = new_speed_y
	speed_up_y(new_speed_y)
	pass
	
func speed_up_y(_value) -> void:
	rotation_tween_y.set_speed_scale(1.0/_value)
	pass

### Helper function to get the X rotation angle (in degrees) in the transformation shader.
func get_rotation_x() -> float:
	return texture.material.get_shader_parameter(SHADER_X_ROTATION)

### Helper function to write an angle (in degrees) to the X rotation parameter in the transformation shader. 
func set_rotation_x(angle: float) -> void:
	texture.material.set_shader_parameter(SHADER_X_ROTATION, angle)

### Helper function to get the Y rotation angle (in degrees) in the transformation shader.
func get_rotation_y() -> float:
	return texture.material.get_shader_parameter(SHADER_Y_ROTATION)

### Helper function to write an angle (in degrees) to the Y rotation parameter in the transformation shader. 
func set_rotation_y(angle: float) -> void:
	texture.material.set_shader_parameter(SHADER_Y_ROTATION, angle)

### Flips a texture on the X axis
func rotate_x(interval: float) -> Tween:
	var original_angle = get_rotation_x()
	var tween = get_tree().create_tween()
	tween.tween_method(set_rotation_x, original_angle, rad_to_deg(TAU), interval).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUART)
	tween.set_parallel()
	tween.tween_method(set_rotation_x, get_rotation_x(), rad_to_deg(TAU), interval).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUART)
	return tween

### Flips a texture on the Y axis
func rotate_y(interval: float) -> void:
	var original_angle = get_rotation_y()
	var tween = get_tree().create_tween()
	tween.tween_method(set_rotation_y, original_angle, rad_to_deg(TAU), interval)
	tween.tween_method(set_rotation_y, get_rotation_y(), rad_to_deg(TAU), interval)

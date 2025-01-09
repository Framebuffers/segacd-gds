class_name LogoBase extends Node2D

@export var texture: TextureRect
@export var path_follow_2d: PathFollow2D

signal process_finished

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

# rotation Z
var rotation_tween_z: Tween
var speedup_ratio_z = 1.0
var speed_z = 1.0:
	set = set_speed_z

func set_speed_z(new_speed_z: float) -> void:
	speed_z = new_speed_z
	speed_up_z(new_speed_z)
	pass
	
func speed_up_z(_value) -> void:
	rotation_tween_z.set_speed_scale(1.0/_value)
	pass

# Pivot truth table:
# 	     |   left   |  center  |  right   |
# 		 |--------------------------------|
#   left | 0.0, 0.0 | 0.5, 0.0 | 1.0, 0.0 |
# center | 0.0, 0.5 | 0.5, 0.5 | 1.0, 0.5 |
#  right | 0.0, 1.0 | 0.5, 1.0 | 1.0, 1.0 |
const Pivots = {
	PIVOT_TOP_LEFT = Vector2(0.0, 0.0),
	PIVOT_TOP_CENTER = Vector2(0.5, 0.0),
	PIVOT_TOP_RIGHT = Vector2(1.0, 0.0),
	PIVOT_CENTER_LEFT = Vector2(0.0, 0.5),
	PIVOT_CENTER = Vector2(0.5, 0.5),
	PIVOT_CENTER_RIGHT = Vector2(1.0, 0.5),
	PIVOT_BOTTOM_LEFT = Vector2(0.0, 1.0),
	PIVOT_BOTTOM_CENTER = Vector2(0.5, 1.0),
	PIVOT_BOTTOM_RIGHT = Vector2(1.0, 1.0)
}
#const PIVOT_TOP_LEFT: Vector2 = Vector2(0.0, 0.0)
#const PIVOT_TOP_CENTER: Vector2 = Vector2(0.5, 0.0)
#const PIVOT_TOP_RIGHT: Vector2 = Vector2(1.0, 0.0)
#const PIVOT_CENTER_LEFT: Vector2 = Vector2(0.0, 0.5)
#const PIVOT_CENTER: Vector2 = Vector2(0.5, 0.5)
#const PIVOT_CENTER_RIGHT: Vector2 = Vector2(1.0, 0.5)
#const PIVOT_BOTTOM_LEFT: Vector2 = Vector2(0.0, 1.0)
#const PIVOT_BOTTOM_CENTER: Vector2 = Vector2(0.5, 1.0)
#const PIVOT_BOTTOM_RIGHT: Vector2 = Vector2(1.0, 1.0)

const SHADER_X_ROTATION = "x_rot"
const SHADER_Y_ROTATION = "y_rot"

func get_texture() -> TextureRect: return texture
func set_texture(new_texture: TextureRect) -> void: texture = new_texture 

func _process(delta: float) -> void: set_texture(texture)

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

### Transforms a texture to resemble one of the fragments of an X shape.
func cross_rotate(interval: float) -> void:
	# rotate_x, rotate_y and rotate the whole texture at 45 degrees (.78 rad)
	# the rads are there because of some funny glitches if I worked with degrees(????)
	var original_angle_x = get_rotation_x()
	var original_angle_y = get_rotation_y()
	#var original_angle = texture.rotation
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_method(set_rotation_x, original_angle_x, rad_to_deg(TAU), interval)
	tween.tween_method(set_rotation_y, original_angle_y, rad_to_deg(TAU), interval)
	#tween.tween_property(texture, "rotation", TAU, interval)

func rotate_following_path(path: PathFollow2D, interval: float) -> void:
	var tween = get_tree().create_tween()
	var original_angle_x = get_rotation_x()
	tween.tween_method(set_rotation_x, original_angle_x, rad_to_deg(TAU), interval)
	texture.position = path.position


## Given a path to follow, update the position of this Node in relation to the path's progress, at a given speed.
## WARN: Must be run in _process().
func move_alongside_path(progress_ratio: float, path_follow: PathFollow2D) -> void:
	path_follow.progress += progress_ratio * get_process_delta_time()

func copy(source: TextureRect, destination: Node2D, offset: Vector2, interval: float) -> void:
	await destination.get_tree().create_timer(interval).timeout
	var new: TextureRect = source.duplicate()
	new.global_position = source.global_position + offset
	destination.add_child(new)

func multi_copy(source: TextureRect, destination: Node2D, offset: Vector2, interval: float, counts: int) -> void:
	var incremental_offset = offset
	for i in counts:
		copy(source, destination, incremental_offset, interval)
		incremental_offset += offset

func bounce(displacement: Vector2, weight: float, angle_rad: float) -> Tween:
	# angles:
	# 	left: (negative)
	# 	right: (positive)
	#
	# maybe: lerp/tween bouncing?
	#
	# goes up, then to one side, then jumps from there to the other, and goes back to the centre.
	# movements are eased_out: like they're in gravity.
	# not going to simulate a whole gravity system.
	
	# jump. positions are all relative to its current position
	
	# take the current position
	# a bounce has:
	# 	- displacement to one side
	# 	- gravity pulls it down
	# 		- thrown to one side multiplied by the weight
	#		- rotate it
	# 		- mirror the bounce back
	
	var tween = texture.create_tween()
	#var original_angle = texture.rotation
	#var original_position = texture.position
	
	## left
	tween.set_parallel()
	tween.tween_property(texture, "rotation", texture.rotation+angle_rad*2, weight).as_relative().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(texture, "position", texture.position-displacement, weight*1.1).as_relative().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(texture, "rotation", angle_rad, weight).as_relative().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	## back
	tween.chain()
	tween.tween_property(texture, "rotation",  texture.rotation-angle_rad, weight*1.25).as_relative().set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel()
	tween.tween_property(texture, "position", texture.position+displacement-(Vector2(0., displacement.y*1.5)), weight*1.25).as_relative().set_ease(Tween.EASE_IN_OUT)
	
	### right
	#
	#tween.chain()
	#tween.tween_property(texture, "rotation", texture.rotation-angle_rad*4, weight).as_relative().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	#tween.set_parallel()
	#tween.tween_property(texture, "position", texture.position+displacement-(Vector2(0., displacement.y*1.5)), weight/.9).as_relative().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	
	## back
	### back
	#tween.chain()
	#tween.tween_property(texture, "rotation",  texture.rotation*angle_rad, weight/1.25).as_relative().set_ease(Tween.EASE_IN_OUT)
	#tween.set_parallel()
	#tween.tween_property(texture, "position", texture.position+displacement, weight/1.25).as_relative().set_ease(Tween.EASE_IN_OUT)
	return tween


# INCREMENTAL BODY ROTATIONS
# rotation_x
func incremental_body_rotation_x(body: Node2D, rotations: int, incremental_multiplier: float) -> void:	
	for i in rotations:
		full_body_rotation_x(body, incremental_multiplier)
		await rotation_tween_x.finished
		print("speedup_ratio: ", speedup_ratio_x)
		speedup_ratio_x += incremental_multiplier
		print(i)
	pass

func full_body_rotation_x(body: Node2D, interval: float) -> void:
	var original_angle = get_rotation_x()
	rotation_tween_x = body.get_tree().create_tween().set_ease(Tween.EASE_IN).parallel()
	speed_x = interval
	rotation_tween_x.set_speed_scale(speed_x)
	rotation_tween_x.tween_method(set_rotation_x, original_angle, rad_to_deg(TAU), interval).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUART)
	rotation_tween_x.set_parallel()
	rotation_tween_x.tween_method(set_rotation_x, get_rotation_x(), rad_to_deg(TAU), interval).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUART)
	if rotation_tween_x.loop_finished:
		speed_x += speedup_ratio_x
		print("speed: ", speed_x, ". loop passed")
		pass


# rotation_y
func incremental_body_rotation_y(body: Node2D, rotations: int, incremental_multiplier: float) -> void:	
	for i in rotations:
		full_body_rotation_x(body, incremental_multiplier)
		await rotation_tween_x.finished
		print("speedup_ratio: ", speedup_ratio_x)
		speedup_ratio_x += incremental_multiplier
		print(i)
	pass

func full_body_rotation_y(body: Node2D, interval: float) -> void:
	var original_angle = get_rotation_y()
	rotation_tween_y = body.get_tree().create_tween().set_ease(Tween.EASE_IN).parallel()
	speed_y= interval
	rotation_tween_y.set_speed_scale(speed_y)
	rotation_tween_y.tween_method(set_rotation_y, original_angle, rad_to_deg(TAU), interval).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUART)
	rotation_tween_y.set_parallel()
	rotation_tween_y.tween_method(set_rotation_y, get_rotation_x(), rad_to_deg(TAU), interval).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUART)
	if rotation_tween_y.loop_finished:
		speed_y += speedup_ratio_y
		print("speed: ", speed_y, ". loop passed")
		pass

# rotation_z
func incremental_body_rotation_z(body: Node2D, rotations: int, incremental_multiplier: float) -> void:	
	for i in rotations:
		full_body_rotation_z(body, incremental_multiplier)
		await rotation_tween_z.finished
		print("speedup_ratio: ", speedup_ratio_z)
		speedup_ratio_z += incremental_multiplier
		print(i)
	pass

func full_body_rotation_z(body: Node2D, interval: float) -> void:
	rotation_tween_z = body.get_tree().create_tween().set_ease(Tween.EASE_IN).parallel()
	speed_z = interval
	rotation_tween_z.set_speed_scale(speed_z)
	rotation_tween_z.tween_method(custom_rotate_z.bind(body), 0.0, TAU, speed_z)
	if rotation_tween_z.loop_finished:
		speed_z += speedup_ratio_z
		print("speed: ", speed_z, ". loop passed")
		pass

func rotate_z(body: Node2D, interval: float) -> Tween:
	#var original_angle = get_rotation_x()
	#var tween = get_tree().create_tween()
	#tween.tween_method(set_rotation_x, original_angle, rad_to_deg(TAU), interval).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUART)
	#tween.set_parallel()
	#tween.tween_method(set_rotation_x, get_rotation_x(), rad_to_deg(TAU), interval).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUART)
	#return tween
	var tween = get_tree().create_tween()
	tween.set_speed_scale(interval)
	tween.tween_method(custom_rotate_z.bind(body), 0.0, TAU, interval)
	tween.set_parallel()
	tween.emit_signal("process_finished")
	return tween


func custom_rotate_z(angle, body):
	body.look_at(body.position + Vector2.from_angle(angle))

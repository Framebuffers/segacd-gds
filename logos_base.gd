extends Node2D

@onready var texture: TextureRect = $TextureRect
@onready var path_follow_2d: PathFollow2D = $"../Paths/Elipsis/PathFollow2D"

# Pivot truth table:
# 	     |   left   |  center  |  right   |
# 		 |--------------------------------|
#   left | 0.0, 0.0 | 0.5, 0.0 | 1.0, 0.0 |
# center | 0.0, 0.5 | 0.5, 0.5 | 1.0, 0.5 |
#  right | 0.0, 1.0 | 0.5, 1.0 | 1.0, 1.0 |

const TOP_LEFT: Vector2 = Vector2(0.0, 0.0)
const TOP_CENTER: Vector2 = Vector2(0.5, 0.0)
const TOP_RIGHT: Vector2 = Vector2(1.0, 0.0)
const CENTER_LEFT: Vector2 = Vector2(0.0, 0.5)
const CENTER: Vector2 = Vector2(0.5, 0.5)
const CENTER_RIGHT: Vector2 = Vector2(1.0, 0.5)
const BOTTOM_LEFT: Vector2 = Vector2(0.0, 1.0)
const BOTTOM_CENTER: Vector2 = Vector2(0.5, 1.0)
const BOTTOM_RIGHT: Vector2 = Vector2(1.0, 1.0)

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
	
	var tween = $TextureRect.create_tween()
	var original_angle = $TextureRect.rotation
	var original_position = $TextureRect.position
	
	## left
	tween.set_parallel()
	tween.tween_property($TextureRect, "rotation", $TextureRect.rotation+angle_rad*2, weight).as_relative().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property($TextureRect, "position", $TextureRect.position-displacement, weight*1.1).as_relative().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($TextureRect, "rotation", angle_rad, weight).as_relative().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	## back
	tween.chain()
	tween.tween_property($TextureRect, "rotation",  $TextureRect.rotation-angle_rad, weight*1.25).as_relative().set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel()
	tween.tween_property($TextureRect, "position", $TextureRect.position+displacement-(Vector2(0., displacement.y*1.5)), weight*1.25).as_relative().set_ease(Tween.EASE_IN_OUT)
	
	### right
	#
	#tween.chain()
	#tween.tween_property($TextureRect, "rotation", $TextureRect.rotation-angle_rad*4, weight).as_relative().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	#tween.set_parallel()
	#tween.tween_property($TextureRect, "position", $TextureRect.position+displacement-(Vector2(0., displacement.y*1.5)), weight/.9).as_relative().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	
	## back
	### back
	#tween.chain()
	#tween.tween_property($TextureRect, "rotation",  $TextureRect.rotation*angle_rad, weight/1.25).as_relative().set_ease(Tween.EASE_IN_OUT)
	#tween.set_parallel()
	#tween.tween_property($TextureRect, "position", $TextureRect.position+displacement, weight/1.25).as_relative().set_ease(Tween.EASE_IN_OUT)
	return tween
#
#func copy(source: TextureRect, destination: Node2D, offset: Vector2, interval: float) -> bool:
	#if true:
		#var timer: Timer = Timer.new()
		#destination.add_child(timer)
		#timer.wait_time = interval
		#timer.one_shot = true
		#timer.start()
		#print(timer.time_left)
		#await timer.timeout
		#var new = source.duplicate()
		#new.position += offset
		#destination.add_child(new)
	#else:
		#pass

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

extends Node

@onready var large = get_node("../Screen/SubViewport/Animation/LogoLarge")
@onready var large_texture = get_node("../Screen/SubViewport/Animation/LogoLarge/TextureRect")
@onready var small = get_node("../Screen/SubViewport/Animation/LogoSmall")
@onready var small_texture = get_node("../Screen/SubViewport/Animation/LogoSmall/TextureRect")
@onready var animation: Node2D = get_node("../Screen/SubViewport/Animation")

var tween_large: Tween
var tween_small: Tween

const LogoBase = preload("res://logo_base.gd")
var logo_routines = LogoBase.new()

const LOCATION = Vector2(5,5)

func _ready() -> void:
	var size = get_viewport().get_window().size
	print(size/2)
	swap_small_with_large()
	#dual_rotations(3, 5)
	pass

func _process(delta: float) -> void:
	print(small.global_position)

# large: rotate_3D
# small: rotate_2D
func dual_rotations(ratio: int, rotations: int) -> void:
	tween_large = large.rotate_x(ratio)
	tween_large.set_loops(rotations)
	tween_large.set_parallel()
	tween_large.play()
	tween_small = small.rotate_z(small, ratio)
	tween_small.set_loops(rotations)
	tween_small.play()

func _quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float) -> Vector2:
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var r = q0.lerp(q1, t)
	return r

func swap_small_with_large() -> void:
	# get vport dimensions
	var center = get_viewport().get_window().size/2
	var small_node: Node2D = small
	large.visible = false
	small.visible = false
	
	small.global_position = center
	small.visible = true
	
	 ##move diagonally
	var x_back = small.global_position.x - center.x/2
	var y_back = small.global_position.y - center.y/2
	#small.global_position.x - center.x/2, small.global_position.y - center.y/2

	#var tween = get_tree().create_tween()
	#tween.tween_property(small, "transform", t, 1)
	
	var position = Vector2(small.global_position.x - center.x/2, small.global_position.y - center.y/2)
	
	var x: Array = _bake_ellipse(50, Vector2(center), Vector2(position))
	for offset in x:
		var tween = get_tree().create_tween()
		tween.tween_property(small, "global_position", offset, 4)
		await tween.finished
	pass
	#for offset in x:
		#small.global_position = small.global_position + offset
		
	
	#var p0: Vector2 = center
	#var p1: Vector2 = center*1.1
	#var p2: Vector2 = position
	#var weight: float = 0.2
	#
	#var q0: Vector2 = p0.lerp(p1, weight)
	#var q1: Vector2 = p1.lerp(p2, weight)
	#
	#var lerp_point = Vector2(small.global_position.x - center.x/4, small.global_position.y - center.y/4)
	
	
	#tween.tween_property(small, "global_position", , 2)
	#var center_2 = Vector2(center.x+20, center.y+20)
	#t.rotated(TAU/4).translated(Vector2(50,50).bezier_interpolate(center, center_2, center_2*1.25, 5))
	#t.translated(Vector2(100, 100))
	
	#tween.tween_property(small, "global_position", small.global_position - Vector2(x_back, 0.0), 4)
	#tween.chain()
	
	#tween.tween_property(small, "transform", Transform2D(0.0, -Vector2(small.global_position.x - center.x/2, small.global_position.y - center.y/2))/2, 1)
	
	
	#tween.tween_property(small, "transform", Transform2D(-PI/2, Vector2(0.5, 0.5), 0.0, Vector2(x_back, y_back)), 3.0)


func transform_from_parent(parent: Node2D, child: Node2D, where: Vector2) -> Transform2D:
	var t = Transform2D()
	#t.origin = target.global_position + where_default_positive
	#t.origin = Vector2(350, 150)
	#
	#var parent = Transform2D(Vector2(2, 0), Vector2(0, 1), Vector2(100, 200))
	#var child = Transform2D(Vector2(0.5, 0), Vector2(0, 0.5), Vector2(100, 100))
	# Calculate the child's world space transform
	# origin = (2, 0) * 100 + (0, 1) * 100 + (100, 200)
	var origin = parent.x * child.origin.x + parent.y * child.origin.y + parent.origin
	# basis_x = (2, 0) * 0.5 + (0, 1) * 0
	var basis_x = parent.x * child.x.x + parent.y * child.x.y
	# basis_y = (2, 0) * 0 + (0, 1) * 0.5
	var basis_y = parent.x * child.y.x + parent.y * child.y.y
	return t

func zoom(source: Node2D, scale: float, rotation_rad: float = 0.0) -> Transform2D:
	var t = Transform2D()
	
	# Translation
	#source.transform = move_to()
	
	## Rotation
	## The rotation to apply.
	#t.x.x = cos(rotation_rad)
	#t.y.y = cos(rotation_rad)
	#t.x.y = sin(rotation_rad)
	#t.y.x = -sin(rotation_rad)
	t.rotated(rotation_rad)
	
	# Scale
	t.x *= scale
	t.y *= scale
	return t

	t.translated(Vector2())
	
	#print(t.origin)
	#source.translate_local(source.position + Vector2.from_angle(angle_rad))
	#print(source.position)
	return t

func uniform_scaling(amount: float) -> Transform2D:
	var t = Transform2D()
	# Scale
	t.x *= amount
	t.y *= amount
	return t

#func move_to(x: float, y: float) -> Transform2D:
	#var t = Transform2D()
	#t.origin = 
	#t.translated_local(Vector2(x, y))
	#return t


func _bake_ellipse(point_count: int, ellipse_center: Vector2, radius: Vector2) -> Array:
	var points = [] 
	for i in range(point_count): 
		var c = i * PI * 2 / point_count
		var x = ellipse_center.x + radius.x * cos(c) 
		var y = ellipse_center.y + radius.y * sin(c)
		points.append(Vector2(x, y)) 
	return points

func _tween_ellipse(target: Node2D, points: Array, duration: float) -> void:
	#var tween: Tween = target.get_tree().create_tween()
	for i in range(points.size() -1):
		var total = 1.0 / (points.size() -1)
		target.global_position = lerp(points[i], points[i+1], duration)
		#tween.set_speed_scale(.1)
		#target.global_position = points[i]
		#tween.interpolate_value(points[i], points[i+1], total, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		#tween.tween_property(target, "global_position", points[i+1], duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		#tween.play()

## NOTE: it only returns the X,Y coords where it should be, it doesn't animate
func ellpise_rotation_offset_xy(ellipse_major_minor: Vector2, radius: float, angle_between_axes_position: float) -> Transform2D:
	var t = Transform2D()
	var center: Vector2 = ellipse_major_minor/2
	
	var x = center.x + ellipse_major_minor.x * cos(angle_between_axes_position) 
	var y = center.y + ellipse_major_minor.y * sin(angle_between_axes_position)
	#var x = center.x + (ellipse_major_minor.x * cos(angle_between_axes_position))
	#var y = center.y + (ellipse_major_minor.y * sin(angle_between_axes_position))
	
	t.translated_local(Vector2(x,y))
	return t

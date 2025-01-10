extends Node

@onready var large = get_node("../Screen/SubViewport/Animation/LogoLarge")
@onready var large_texture = get_node("../Screen/SubViewport/Animation/LogoLarge/TextureRect")
@onready var small = get_node("../Screen/SubViewport/Animation/LogoSmall")
@onready var small_texture = get_node("../Screen/SubViewport/Animation/LogoSmall/TextureRect")
@onready var animation: Node2D = get_node("../Screen/SubViewport/Animation")


var tween_large: Tween
var tween_small: Tween


#func _ready() -> void:
	#for node in get_tree().root.get_children(true):
		#print(node.name)
	
	#var center = get_viewport().get_window().size/2
	#var position = Vector2(small.global_position.x - center.x/2, small.global_position.y - center.y/2)
	#var size = get_viewport().get_window().size
	#rotate_from_offset(small, Vector2(200, 50).rotated(TAU/12), 50, center)
	#pass

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
		tween.tween_property(small, "global_position", offset, .1)
		await tween.finished
	pass

func transform_from_parent(parent: Node2D, child: Node2D, where: Vector2) -> Transform2D:
	var t = Transform2D()
	var origin = parent.x * child.origin.x + parent.y * child.origin.y + parent.origin
	var basis_x = parent.x * child.x.x + parent.y * child.x.y
	var basis_y = parent.x * child.y.x + parent.y * child.y.y
	return t

func zoom(source: Node2D, scale: float, rotation_rad: float = 0.0) -> Transform2D:
	var t = Transform2D()
	t.x *= scale
	t.y *= scale
	return t.rotated(rotation_rad)

func uniform_scaling(amount: float) -> Transform2D:
	var t = Transform2D()
	t.x *= amount
	t.y *= amount
	return t

func _bake_ellipse(point_count: int, ellipse_center: Vector2, radius: Vector2) -> Array:
	var points = [] 
	for i in range(point_count): 
		var c = i * PI * 2 / point_count
		var x = ellipse_center.x + radius.x * cos(c) 
		var y = ellipse_center.y + radius.y * sin(c)
		points.append(Vector2(x, y)) 
	return points

## NOTE: it only returns the X,Y coords where it should be, it doesn't animate
func rotate_from_offset(body: Node2D, circle_x_y: Vector2, delta_between_points: float, origin_point: Vector2, rotation: float = 0.0) -> void:
	# get vport dimensions
	#var center = get_viewport().get_window().size/2
	#var center = origin_point
	#var small_node: Node2D = small
	#var xz = origin_point
	body.global_position = origin_point
	body.visible = true
	#var xd: Vector2 = origin_point.
	###move diagonally
	#var x_back = body.global_position.x - origin_point.x/2
	#var y_back = body.global_position.y - origin_point.y/2
	#small.global_position.x - center.x/2, small.global_position.y - center.y/2

	#var tween = get_tree().create_tween()
	#tween.tween_property(small, "transform", t, 1)
	
	#var position = Vector2(body.global_position.x - center.x/2, body.global_position.y - center.y/2)
	#print("ellipse_center: ", Vector2(center), ", position: ", Vector2(100, 100), "\n")
	var x: Array = _bake_ellipse(10, origin_point, circle_x_y)
	for offset in x:
		var xd: Vector2 = offset
		var tween = get_tree().create_tween()
		tween.tween_property(body, "global_position", offset, .1)
		await tween.finished
		#print("offset: x = ", offset.x, " y= ", offset.y, "\n\t[diff= ", Vector2(origin_point.x, origin_point.x), ", ", Vector2(origin_point.y, offset.y), " \n\tposition= ", Vector2(offset.x, offset.x), ", ", Vector2(origin_point.x, offset.x), "]\n\n")
	pass

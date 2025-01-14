class_name cycle1 extends Node2D
const Main = preload("res://main.gd")
var main = Main.new()

signal done

var a: LogoBase
var b: LogoBase
var viewport: SubViewport

func _init(node_a: LogoBase, node_b: LogoBase, vport: SubViewport) -> void:
	a = node_a
	b = node_b
	viewport = vport

	#var vport_x = vport.size.x
	#var vport_y = vport.size.y
	#
	#print("top_left: ", 0, "x", 0)
	#var top_left = Vector2(0, 0)
	#
	#print("top_center: ", vport_x/2, "x", 0)
	#var top_center = Vector2(vport_x, vport_y)
	#
	#print("top_right: ", vport_x, "x", 0)
	#var top_right = Vector2(vport_x, vport_y)
	#
	#print("center_left: : ", 0, "x", vport_y/2)
	#var center_left = Vector2(vport_x, vport_y)
	#
	#print("center: ", vport_x/2, "x", vport_y/2)
	#var center = Vector2(vport_x, vport_y)
	#
	#print("center_right: ", vport_x, "x", vport_y/2)
	#var center_right = Vector2(vport_x, vport_y)
	#
	#print("bottom_left: ", 0, "x", vport_y)
	#var bottom_left = Vector2(vport_x, vport_y)
	#
	#print("bottom_center: ", vport_x/2, "x", vport_y)
	#var bottom_center = Vector2(vport_x, vport_y)
	#
	#print("bottom_right: ", vport_x, "x", vport_y)
	#var bottom_right = Vector2(vport_x, vport_y)

func anim0_swap(transition_timer_1: float, transition_speed_1: float, transition_timer_2: float, transition_speed_2: float) -> void:
	# init
	var center = viewport.size/2
	var third: Vector2 = viewport.size/3
	var third_left: Vector2 = Vector2(center.x+third.x/2, third.y*2)
	#var third_right: Vector2 = Vector2(third.x+, third.y)
	a.global_position = center
	b.global_position = center
	
	a.visible = true
	a.z_index = 1
	b.visible = false

	
	# wait
	var t_a = a.get_tree().create_timer(transition_timer_1)
	await t_a.timeout
	b.visible = false
	
	var translate_to_back = Transform2D()
	translate_to_back.translated(center)
	
	
	#a.rotate_from_offset(a, third, 100, center, 1, -PI/2)
	
	# first swap:
	var t1 = a.get_tree().create_tween().bind_node(a).set_ease(Tween.EASE_IN_OUT)
	
	t1.tween_property(a, "transform", Transform2D(0.0, Vector2(.5, .5), 0.0, third), transition_speed_1)
	print(a.global_position)
	t1.chain()
	b.visible = true
	b.scale = Vector2(.1, .1)
	t1.tween_property(a, "transform", Transform2D(0.0, Vector2(.1, .1), 0.0, center), transition_speed_1)
	print(a.global_position)
	a.z_index = -1
	b.z_index = 0
	
	var t2 = b.get_tree().create_tween().bind_node(b).set_ease(Tween.EASE_IN_OUT) 
	print(b.global_position)
	t2.tween_property(b, "transform", Transform2D(0.0, Vector2(.5, .5), 0.0, third_left), transition_speed_1)
	t2.chain()
	t2.tween_property(b, "transform", Transform2D(0.0, Vector2(1, 1), 0.0, center), transition_speed_1)
	print(b.global_position)
	await t2.finished
	
	var t_b = a.get_tree().create_timer(transition_timer_2)
	await t_b.timeout
	
	# second swap
	var t3 = b.get_tree().create_tween().bind_node(b).set_ease(Tween.EASE_IN_OUT)
	t3.tween_property(b, "transform", Transform2D(0.0, Vector2(.5, .5), 0.0, Vector2(center.x+center.x/3, center.y-center.y/3)), transition_speed_2)
	t3.set_parallel()
	t3.tween_property(a, "transform", Transform2D(0.0, Vector2(.5, .5), 0.0, Vector2(center.x-center.x/3, center.y+center.y/3)), transition_speed_2)
	t3.chain()
	
	t3.tween_property(b, "transform", Transform2D(0.0, Vector2(.1, .1), 0.0, center), transition_speed_2)
	b.z_index = -1
	a.z_index = 0
	t3.set_parallel()
	t3.tween_property(a, "transform", Transform2D(0.0, Vector2(1, 1), 0.0, center), transition_speed_2)
	await t3.finished
	done.emit()

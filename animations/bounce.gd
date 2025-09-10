class_name bounce extends Node2D

var a: LogoBase
var b: LogoBase
var viewport: SubViewport

func _init(node_a: LogoBase, node_b: LogoBase, vport: SubViewport) -> void:
	a = node_a
	b = node_b
	viewport = vport

func exec() -> void:
	var center: Vector2 = viewport.size/2
	var third: Vector2 = viewport.size/3
	var third_left: Vector2 = Vector2(center.x+third.x/2, third.y*2)
	var third_right_top: Vector2 = Vector2(center.x+center.x/3, center.y-center.y/3)
	var third_right_bottom: Vector2 = Vector2(center.x-center.x/3, center.y+center.y/3)
	var away: Vector2 = Vector2(viewport.size) + Vector2(viewport.size.x * 2, 0)
	
	a.global_position = center
	#b.global_position = away
	
	a.visible = true
	
	var tween = a.get_tree().create_tween()
	var angle_rad = PI/6
	var weight = 2
	var displacement = Vector2(100,100)
	## left
	tween.set_parallel()
	tween.tween_property(a, "rotation", a.rotation+angle_rad*2, weight).as_relative().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(a, "position", a.position-displacement, weight*1.1).as_relative().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(a, "rotation", a, weight).as_relative().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	## back
	tween.chain()
	tween.tween_property(a, "rotation",  a.rotation-angle_rad, weight*1.25).as_relative().set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel()

	#var bounce_b: Tween = b.bounce(Vector2(20, 20), 3, TAU/12)
	#

	#bounce_a.set_parallel()
	#bounce_a.tween_property(a, "global_position", a.global_position + Vector2(Vector2(viewport.size.x/2, 0)), 1.5)
	#

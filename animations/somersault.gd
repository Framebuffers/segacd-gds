class_name somersault extends Node2D
const Main = preload("res://main.gd")
var main = Main.new()

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
	
	# starting position: change to current in final
	a.global_position = center
	b.global_position = center
	
	# change to use the current state of the screen, not a default one
	a.visible = true
	b.visible = false
	
	# jump to upper third of screen
	var jump_height: Vector2 = Vector2(center.x, center.y-center.y/3)

	
	
	# set visibility: this effect relies on three things: position, rotation and scaling.
	# the z_index is the order on which elements are rendered on screen.
	# for this effect, each logo goes up, turns and comes back down on top of the previous logo.
	b.visible = true
	b.z_index = -1
	a.z_index = 0
	
	## Loop 1: two loops are completed and then each logo flies away to the left or right.
	# logo A
	var jump_a1 = a.get_tree().create_tween().bind_node(a).set_ease(Tween.EASE_OUT)
	jump_a1.tween_property(a, "global_position", Vector2(a.global_position.x, jump_height.y), 1) # move up
	jump_a1.set_parallel()
	a.rotate_x(1.5) # turn
	jump_a1.chain()
	jump_a1.tween_property(a, "scale", Vector2(1.5, 1.5), .5) # scale
	jump_a1.set_parallel()
	jump_a1.tween_property(a, "global_position", center, .5) # back down
	await jump_a1.finished
	
	# logo B
	b.visible = true
	var jump_b1 = b.get_tree().create_tween().bind_node(b).set_ease(Tween.EASE_OUT)
	jump_height = Vector2(center.x, center.y-center.y*2)
	jump_b1.tween_property(b, "global_position", Vector2(a.global_position.x, jump_height.y), 1)
	var rotate_b1: Tween = b.rotate_x(1.5)
	rotate_b1.play()
	rotate_b1.chain()
	b.z_index = 0
	jump_b1.tween_property(b, "global_position", center, .5)
	jump_b1.set_parallel()
	jump_b1.tween_property(b, "scale", Vector2(1.5, 1.5), .5)
	await jump_b1.finished
	
	## Loop 2
	# logo A
	b.z_index = -1
	var jump_a2 = a.get_tree().create_tween().bind_node(a).set_ease(Tween.EASE_OUT)
	jump_height = Vector2(center.x, center.y-center.y*4)
	jump_a2.tween_property(a, "global_position", Vector2(a.global_position.x, jump_height.y), 1) # move up
	jump_a2.set_parallel()
	a.rotate_x(1.5) # turn
	jump_a2.chain()
	jump_a2.tween_property(a, "scale", Vector2(3.0, 3.0), .5) # scale
	jump_a2.set_parallel()
	jump_a2.tween_property(a, "global_position", center, .5) # back down
	await jump_a2.finished
	
	# logo B
	
	b.visible = true
	var jump_b2 = b.get_tree().create_tween().bind_node(b).set_ease(Tween.EASE_OUT)
	jump_height = Vector2(center.x, center.y-center.y*8)
	jump_b2.tween_property(b, "global_position", Vector2(a.global_position.x, jump_height.y), 1)
	var jump_c2 = b.get_tree().create_tween().bind_node(b).set_ease(Tween.EASE_OUT)
	var rotate_b: Tween = b.rotate_x(1.5)
	rotate_b.play()
	rotate_b.chain()
	b.z_index = 0
	jump_b2.tween_property(b, "global_position", b.global_position + center, .5)
	jump_b2.set_parallel()
	jump_b2.tween_property(b, "scale", Vector2(3., 3.), .5)
	await jump_b2.finished

	
	var away_l = a.get_tree().create_tween().bind_node(a).set_ease(Tween.EASE_OUT)
	var away_r = b.get_tree().create_tween().bind_node(b).set_ease(Tween.EASE_OUT)
	away_l.tween_property(a, "transform", Transform2D(TAU/2, a.scale, a.skew, center - center*4), 1)
	away_r.tween_property(b, "transform", Transform2D(-TAU/2, b.scale, b.skew, center + center*4), 1)

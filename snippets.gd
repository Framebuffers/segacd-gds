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
	
	
	#tween.tween_property(small, "transform", Transform2D(-PI/2, Vector2(0.5, 0.5), 0.0, Vector2(x_back, y_back)), 3.0)extends Node

#func rotate_z(body: Node2D, interval: float) -> Tween:
	##var original_angle = get_rotation_x()
	##var tween = get_tree().create_tween()
	##tween.tween_method(set_rotation_x, original_angle, rad_to_deg(TAU), interval).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUART)
	##tween.set_parallel()
	##tween.tween_method(set_rotation_x, get_rotation_x(), rad_to_deg(TAU), interval).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUART)
	##return tween
	#var tween = get_tree().create_tween()
	#tween.set_speed_scale(interval)
	#tween.tween_method(custom_rotate_z.bind(body), 0.0, TAU, interval)
	#tween.set_parallel()
	#tween.emit_signal("process_finished")
	#return tween
#

#func bounce(displacement: Vector2, weight: float, angle_rad: float) -> Tween:
	## angles:
	## 	left: (negative)
	## 	right: (positive)
	##
	## maybe: lerp/tween bouncing?
	##
	## goes up, then to one side, then jumps from there to the other, and goes back to the centre.
	## movements are eased_out: like they're in gravity.
	## not going to simulate a whole gravity system.
	#
	## jump. positions are all relative to its current position
	#
	## take the current position
	## a bounce has:
	## 	- displacement to one side
	## 	- gravity pulls it down
	## 		- thrown to one side multiplied by the weight
	##		- rotate it
	## 		- mirror the bounce back
	#
	#var tween = texture.create_tween()
	##var original_angle = texture.rotation
	##var original_position = texture.position
	#
	### left
	#tween.set_parallel()
	#tween.tween_property(texture, "rotation", texture.rotation+angle_rad*2, weight).as_relative().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
	#tween.tween_property(texture, "position", texture.position-displacement, weight*1.1).as_relative().set_ease(Tween.EASE_IN_OUT)
	#tween.tween_property(texture, "rotation", angle_rad, weight).as_relative().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	### back
	#tween.chain()
	#tween.tween_property(texture, "rotation",  texture.rotation-angle_rad, weight*1.25).as_relative().set_ease(Tween.EASE_IN_OUT)
	#tween.set_parallel()
	#tween.tween_property(texture, "position", texture.position+displacement-(Vector2(0., displacement.y*1.5)), weight*1.25).as_relative().set_ease(Tween.EASE_IN_OUT)
	#
	#### right
	##
	##tween.chain()
	##tween.tween_property(texture, "rotation", texture.rotation-angle_rad*4, weight).as_relative().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	##tween.set_parallel()
	##tween.tween_property(texture, "position", texture.position+displacement-(Vector2(0., displacement.y*1.5)), weight/.9).as_relative().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	#
	### back
	#### back
	##tween.chain()
	##tween.tween_property(texture, "rotation",  texture.rotation*angle_rad, weight/1.25).as_relative().set_ease(Tween.EASE_IN_OUT)
	##tween.set_parallel()
	##tween.tween_property(texture, "position", texture.position+displacement, weight/1.25).as_relative().set_ease(Tween.EASE_IN_OUT)
	#return tween
#

#
### NOTE: it only returns the X,Y coords where it should be, it doesn't animate
#func ellipse_rotation_offset(body: Node2D, origin: Vector2, ellipse: Node2D, duration: float) -> void:
	## get vport dimensions
	#var center = get_viewport().get_window().size/2
	#var small_node: Node2D = small
	#large.visible = false
	#small.visible = false
	#
	#small.global_position = center
	#small.visible = true
	#
	###move diagonally
	#var x_back = small.global_position.x - center.x/2
	#var y_back = small.global_position.y - center.y/2
	##small.global_position.x - center.x/2, small.global_position.y - center.y/2
#
	##var tween = get_tree().create_tween()
	##tween.tween_property(small, "transform", t, 1)
	#
	#var position = Vector2(small.global_position.x - center.x/2, small.global_position.y - center.y/2)
	#var x: Array = _bake_ellipse(50, Vector2(center), Vector2(position))
	#
	#for offset in x:
		#var tween = get_tree().create_tween()
		#tween.tween_property(small, "global_position", offset, .1)
		#await tween.finished
	#pass

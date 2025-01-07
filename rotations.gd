extends Node

var rotation_tween: Tween
var speedup_ratio = 1.0
var speed = 1.0:
	set = set_speed

func set_speed(new_speed: float) -> void:
	speed = new_speed
	speed_up(new_speed)
	pass
	
func speed_up(_value) -> void:
	rotation_tween.set_speed_scale(1.0/_value)
	pass

func incremental_body_rotation(body: Node2D, rotations: int, incremental_multiplier: float) -> void:	
	for i in rotations:
		full_body_rotation(body, 1)
		await rotation_tween.finished
		print(speedup_ratio)
		speedup_ratio *= incremental_multiplier
		print(i)
	pass

func full_body_rotation(body: Node2D, interval: float) -> void:
	rotation_tween = body.get_tree().create_tween().set_ease(Tween.EASE_IN)
	speed = interval
	rotation_tween.set_speed_scale(speed)
	rotation_tween.tween_method(custom_rotate.bind(body), 0.0, TAU, speed)
	if rotation_tween.loop_finished:
		speed /= speedup_ratio
		print("speed: ", speed, ". loop passed")
		pass

func custom_rotate(angle, body):
	body.look_at(body.position + Vector2.from_angle(angle))

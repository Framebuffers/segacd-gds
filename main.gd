extends Node

@onready var large = get_node("../Screen/SubViewport/Animation/LogoLarge")
@onready var small = get_node("../Screen/SubViewport/Animation/LogoSmall")

func _ready() -> void:
	large.rotate_x(3.0)
	#transform_rotation_y(large)
	#incremental_body_rotation(large, 3, 2.0)
	
	#large.turn(10.0)
	#flip(large_texture, 3.0)
	pass

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
	rotation_tween = get_tree().create_tween().set_ease(Tween.EASE_IN)
	speed = interval
	rotation_tween.set_speed_scale(speed)
	rotation_tween.tween_method(custom_rotate.bind(body), 0.0, TAU, speed)
	if rotation_tween.loop_finished:
		speed /= speedup_ratio
		print("speed: ", speed, ". loop passed")
		pass

func custom_rotate(angle, body):
	body.look_at(body.position + Vector2.from_angle(angle))

@export var scale: Vector2
@export var skew: float
@export var position: Vector2

func transform_rotation_y(body: Node2D) -> void:
	body.transform = Transform2D(
		TAU,
		scale,
		skew,
		position)
	pass



func flip(texture: TextureRect, duration: float) -> void:
	#var shader = texture.material.set_shader_parameter('y_rot', 90)
	#var tween = texture.get_tree().create_tween().bind_node(texture)
	##texture.flip_h
	#tween.tween_property(texture, "scale", Vector2(1.0, 1.0), 0.1)
	#tween.tween_property(texture, "scale", Vector2(1.0, 1.0), duration)
	pass

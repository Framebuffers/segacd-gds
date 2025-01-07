extends Node

@onready var large = get_node("../Screen/SubViewport/Animation/LogoLarge")
@onready var large_texture = get_node("../Screen/SubViewport/Animation/LogoLarge/TextureRect")
@onready var small = get_node("../Screen/SubViewport/Animation/LogoSmall")
@onready var animation: Node2D = get_node("../Screen/SubViewport/Animation")
const Rotations = preload("res://rotations.gd")
var rotations = Rotations.new()

func _ready() -> void:
	rotations.incremental_body_rotation(large, 3, 2.0)
	pass

func _process(delta: float) -> void:
	large.move_alongside_path(10.0, get_node("../Screen/SubViewport/Animation/Paths/Elipsis/PathFollow2D/"))


#@export var scale: Vector2
#@export var skew: float
#@export var position: Vector2
#
#func transform_rotation_y(body: Node2D) -> void:
	#body.transform = Transform2D(
		#TAU,
		#scale,
		#skew,
		#position)
	#pass

#func _physics_process(delta: float) -> void:
	#large.global_position = remote_transform_2d.global_position

#func flip(texture: TextureRect, duration: float) -> void:
	##var shader = texture.material.set_shader_parameter('y_rot', 90)
	##var tween = texture.get_tree().create_tween().bind_node(texture)
	###texture.flip_h
	##tween.tween_property(texture, "scale", Vector2(1.0, 1.0), 0.1)
	##tween.tween_property(texture, "scale", Vector2(1.0, 1.0), duration)
	#pass

extends Node

@onready var large = get_node("../Screen/SubViewport/Animation/LogoLarge")
@onready var large_texture = get_node("../Screen/SubViewport/Animation/LogoLarge/TextureRect")
@onready var small = get_node("../Screen/SubViewport/Animation/LogoSmall")
@onready var animation: Node2D = get_node("../Screen/SubViewport/Animation")
const Rotations = preload("res://rotations.gd")
var rotations = Rotations.new()
var location = Vector2(5,5)

func _ready() -> void:
	#var tween1: Tween = large.bounce(Vector2(50.0, -50.0), 0.3, -0.1)
	large.multi_copy(large_texture, animation, location, get_process_delta_time(), 10)
	#var tween2: Tween = large.bounce(Vector2(-100, 100), .5, -0.1)
	#rotations.incremental_body_rotation(large, 10, 1.0)
	#rotations.incremental_body_rotation_loop_finished.connect(on_finished_rotation)
	pass

func on_finished_rotation() -> void:
	print("signal emitted from finished loop")


#func _process(delta: float) -> void:
	
	#location += location*.25
	###large.move_alongside_path(.1, get_node("../Screen/SubViewport/Animation/Paths/Elipsis/PathFollow2D/"))


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

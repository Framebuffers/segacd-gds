class_name Rotations extends Node2D

@onready var large = get_node("../Screen/SubViewport/Animation/LogoLarge")
@onready var large_texture = get_node("../Screen/SubViewport/Animation/LogoLarge/TextureRect")
@onready var small = get_node("../Screen/SubViewport/Animation/LogoSmall")
@onready var animation: Node2D = get_node("../Screen/SubViewport/Animation")
@onready var small_texture = get_node("../Screen/SubViewport/Animation/LogoSmall/TextureRect")


#const LogoBase = preload("res://logo_base.gd")
#const Pivots: Dictionary = LogoBase.Pivots
#
#enum RotationTypes {
	#ROTATION_CONSTANT,
	#ROTATION_INCREMENTAL,
	#ROTATION_PERSPECTIVE,
#}
#
#static func spin_up(target: Node2D, rotations: int, impulse: float) -> void:
	#var base = LogoBase.new()
	#base.incremental_body_rotation(target, rotations, impulse)
#
#static func rotation_3D_x(target: Node2D, rotations: int, impulse: float) -> void:
	#var base = LogoBase.new()
	#for i in rotations:
		#base.rotate_x(impulse)
		#print(i)

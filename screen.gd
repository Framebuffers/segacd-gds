extends Node2D
var root: Node
#

@onready var large_texture = $SubViewport/Animation/LogoLarge/TextureRect
@onready var small_texture = $SubViewport/Animation/LogoSmall/TextureRect

@onready var animation = $SubViewport/Animation

@onready var large: LogoBase = $SubViewport/Animation/LogoLarge
@onready var small: LogoBase = $SubViewport/Animation/LogoSmall


func _ready() -> void:
	root = get_node("/root/Main")
	var center = get_viewport().get_window().size/2
	var position = Vector2(small.global_position.x - center.x/2, small.global_position.y - center.y/2)
	var size = get_viewport().get_window().size
	#root.rotate_from_offset(small, Vector2(200, 50).rotated(TAU/12), 50, center)
	small.visible = true
	small.global_position = center

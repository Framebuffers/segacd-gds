extends Node

@onready var large = get_node("../Screen/SubViewport/Animation/LogoLarge")
@onready var small = get_node("../Screen/SubViewport/Animation/LogoSmall")

func _ready() -> void:
	incremental_full_body_rotation(large, 3, 2)
	#rotate_body(large, 3, 3)
	#transform_rotation_incrementally(large, 3, 5)
	pass

func incremental_full_body_rotation(body: Node2D, rotations: float, interval: float) -> void:
	var counter = rotations
	for i in counter:
		full_body_rotation(body, interval)
		counter - 1
	pass

	
func _process(delta: float) -> void:
	#rotate_body_incrementally(large, 3, 5.0)
	pass

func full_body_rotation(body: Node2D, interval: float) -> void:
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN)
	tween.tween_method(custom_rotate.bind(body), 0.0, TAU, interval)

func custom_rotate(angle, body):
	#print(body, angle)
	body.look_at(body.position + Vector2.from_angle(angle))
	
	#for i in rotations:
		#tween.tween_property(body, "rotation", TAU, interval)
		#interval = clampf(interval - interval/2, 0, interval)
		#
		#if interval < 0.2:
			#break
		#pass
		

# tween
#func rotate_body(body: Node2D, rad: float, interval: float) -> void:
	#var tween = get_tree().create_tween()
	#tween.bind_node(body)
	## tween it lmaooooo
	#pass
#
#
#func transform_rotation_rad(body: Node2D, angle: int, speed: float) -> void:
	#body.transform.x = Vector2(cos(angle), sin(angle))
#
## old
##func rotate_body_incrementally(body: Node2D, rotations: int, interval: float) -> void:
	##rotate_body(body, body.rotation * rotations, interval)
##pass

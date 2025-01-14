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

func anim1_somersault() -> void:
	var t_a: Tween = a.rotate_x(1.5)
	var t_b: Tween = b.rotate_x(1.5)
	
	
	var t1 = a.get_tree().create_tween().bind_node(a).set_ease(Tween.EASE_IN_OUT)
	a.z_index = -1
	t1.tween_property(b, "scale", Vector2(1.5, 1.5), 1.5)
	t1.set_parallel()
	t_b.play()

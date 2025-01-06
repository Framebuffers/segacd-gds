extends TextureRect

@export var x_rotation: float = 0.0:
	set(value):
		material.set_shader_parameter('x_rot', value)
	get:
		return material.get_shader_parameter('x_rot')

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

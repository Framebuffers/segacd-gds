extends Node2D

#@onready var large: LogoBase = $LogoLarge
#@onready var small: LogoBase = $LogoSmall
#@onready var logo_3: Node2D = $Logo3

@onready var large: LogoBase = $LogoLarge
@onready var small: LogoBase = $LogoSmall

const Cycle1 = preload("res://animations/cycle1.gd")
const Somersault = preload("res://animations/somersault.gd")

func _ready() -> void:
	#var cycle1 = Cycle1.new(large, small, $"..")
	var somersault_1 = Somersault.new(large, small, $"..")
	large.visible = false
	small.visible = false
	
	var t = get_tree().create_timer(3)
	await t.timeout
	
	#cycle1.exec(2, 1, 1, 1)
	#await cycle1.done
	#
	somersault_1.exec()
	pass

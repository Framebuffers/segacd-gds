extends Node

@onready var large = get_node("../Screen/SubViewport/Animation/LogoLarge")
@onready var small = get_node("../Screen/SubViewport/Animation/LogoSmall")

@onready var center = get_viewport().get_window().size/2

extends Node2D

@onready var icon: Sprite2D = $Icon

func select() -> void:
	icon.show()

func deselect() -> void:
	icon.hide()

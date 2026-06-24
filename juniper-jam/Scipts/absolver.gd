extends Node2D

@onready var icon: Sprite2D = $Icon
@onready var area_2d: Area2D = $Icon/Area2D
@onready var collision_shape_2d: CollisionShape2D = $Icon/Area2D/CollisionShape2D

func select() -> void:
	icon.show()
	area_2d.monitorable = true
	area_2d.monitoring = true
	collision_shape_2d.disabled = false

func deselect() -> void:
	icon.hide()
	area_2d.monitorable = false
	area_2d.monitoring = false
	collision_shape_2d.disabled = true

func absolve() -> void:
	for area in $Icon/Area2D.get_overlapping_areas():
		var target = area.get_parent().get_parent()

		if target and target.has_method("absolution"):
			target.absolution()

extends Node2D

@onready var icon: AnimatedSprite2D = $Icon
@onready var area_2d: Area2D = $Icon/Area2D
@onready var collision_shape_2d: CollisionShape2D = $Icon/Area2D/CollisionShape2D
@onready var big_staff: Sprite2D = $BigStaff
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera_2d: Camera2D = $"../Camera2D"

@onready var outer_ring: Node2D = $"../OuterRing"
@onready var middle_ring: Node2D = $"../MiddleRing"
@onready var inner_ring: Node2D = $"../InnerRing"


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
	$Bell.play()
	Globals.canMove = false
	icon.hide()
	animation_player.play("drop")

func shake() -> void:
	camera_2d.trigger_shake()
	$"Explosion(9)".play()
	Globals.canMove = true
	for area in $Icon/Area2D.get_overlapping_areas():
		var target = area.get_parent().get_parent()
		if target and target.has_method("absolution"):
			target.absolution()
	check_win()

func check_win() -> void:
	var rings = [outer_ring, middle_ring, inner_ring]
	for ring in rings:
		var slices_node = ring.get_node("Slices")
		for i in range(1, 7):
			var slice = slices_node.get_node("Slice%d" % i)
			if not slice.isGood:
				print("not win")
				return
	print("win")
	

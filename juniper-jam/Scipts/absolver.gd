extends Node2D

@onready var icon: AnimatedSprite2D = $Icon
@onready var area_2d: Area2D = $Icon/Area2D
@onready var collision_shape_2d: CollisionShape2D = $Icon/Area2D/CollisionShape2D
@onready var big_staff: Sprite2D = $BigStaff
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera_2d: Camera2D = $"../Camera2D"

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
	for area in $Icon/Area2D.get_overlapping_areas():
		var target = area.get_parent().get_parent()
		if target and target.has_method("absolution"):
			target.absolution()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "drop":
		Globals.canMove = true
		icon.show()
		get_parent().get_parent().check_win()

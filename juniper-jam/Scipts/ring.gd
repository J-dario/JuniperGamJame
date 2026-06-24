extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func highlightRing() -> void:
	$OutlineRing.material.set_shader_parameter("thickness", 3)

func unhighlightRing() -> void:
	$OutlineRing.material.set_shader_parameter("thickness", 0)

func rotateRight() -> void:
	rotation += deg_to_rad(60)

func rotateLeft() -> void:
	rotation += deg_to_rad(-60)

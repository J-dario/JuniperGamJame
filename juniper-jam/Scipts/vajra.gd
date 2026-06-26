extends Node2D

var used := false
@onready var item: CanvasGroup = $Item

func _ready() -> void:
	item.material = item.material.duplicate()
	
func usedAnim() -> void:
	var material := item.material as ShaderMaterial
	used = true

	var tween := create_tween()
	tween.tween_method(
		func(value):
			material.set_shader_parameter("progress", value),
		-0.7,
		1.3,
		1
	)

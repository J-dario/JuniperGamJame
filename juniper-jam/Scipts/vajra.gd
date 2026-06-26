extends Node2D

var used := false
@onready var item: CanvasGroup = $Item
@onready var used_sound: AudioStreamPlayer2D = $usedSound


func _ready() -> void:
	item.material = item.material.duplicate()
	print(used_sound)
	print(get_path_to($usedSound))
	
func usedAnim() -> void:
	var material := item.material as ShaderMaterial
	used = true
	
	used_sound.play()
	
	var tween := create_tween()
	tween.tween_method(
		func(value):
			material.set_shader_parameter("progress", value),
		-0.7,
		1.3,
		0.75
	)

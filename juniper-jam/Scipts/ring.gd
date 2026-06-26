extends Node2D
@onready var audio_stream_player_2d_4: AudioStreamPlayer2D = $"../AudioStreamPlayer2D4"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$OutlineRing.material.set_shader_parameter("thickness", 0)

func highlightRing() -> void:
	$OutlineRing.material.set_shader_parameter("thickness", 3)

func unhighlightRing() -> void:
	$OutlineRing.material.set_shader_parameter("thickness", 0)

# stop can move, remove outline, lerp wheel, play sfx, brin back outline
func rotateRight() -> void:
	Globals.canMove = false
	unhighlightRing()
	audio_stream_player_2d_4.play()
	
	var tween := get_tree().create_tween()
	tween.tween_property(self, "rotation", (rotation + deg_to_rad(60)), 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	
	tween.finished.connect(func():
		highlightRing()
		Globals.canMove = true
		get_parent().get_parent().check_win()
	)
	
	get_parent().get_parent().check_win()

func rotateLeft() -> void:
	Globals.canMove = false
	unhighlightRing()
	audio_stream_player_2d_4.play()
	
	var tween := get_tree().create_tween()
	tween.tween_property(self, "rotation", (rotation - deg_to_rad(60)), 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	
	tween.finished.connect(func():
		highlightRing()
		Globals.canMove = true
		get_parent().get_parent().check_win()
	)
	
	get_parent().get_parent().check_win()

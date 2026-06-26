extends Node2D

@onready var wheel: Node2D = $Wheel
@onready var outer_ring: Node2D = $Wheel/OuterRing
@onready var middle_ring: Node2D = $Wheel/MiddleRing
@onready var inner_ring: Node2D = $Wheel/InnerRing
@onready var center: Sprite2D = $Wheel/Center
@onready var dead_center: Sprite2D = $Wheel/DeadCenter
@onready var logo: Sprite2D = $Logo
@onready var play: Sprite2D = $Play
@onready var level_select: Sprite2D = $LevelSelect
@onready var audio_stream_player_2d_3: AudioStreamPlayer2D = $Wheel/AudioStreamPlayer2D3


var startRotate = false
var transitioning = false
var bob_time := 0.0

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Intro":
		startRotate = true

func _process(delta: float) -> void:
	if startRotate and not transitioning:
		outer_ring.rotation += 0.1 * delta
		middle_ring.rotation -= 0.1 * delta
		inner_ring.rotation += 0.15 * delta
		center.rotation -= 0.15 * delta
		dead_center.rotation += 0.15 * delta
		
		bob_time += delta
		logo.position.y = -89.0 + sin(bob_time * 1.5) * 10.0
		play.position.y = 31.0 + sin(bob_time * 1.5) * 5.0
		level_select.position.y = 101.0 + sin(bob_time * 1.5) * 5.0

func _on_play_button_mouse_entered() -> void:
	play.modulate = Color("ffffff")
	$Hover.play()
func _on_play_button_mouse_exited() -> void:
	play.modulate = Color("c1c1c1")

func _on_play_button_pressed() -> void:
	$Select.play()
	logo.hide()
	play.hide()
	level_select.hide()
	
	transitioning = true
	
	audio_stream_player_2d_3.play()
	
	var tween := get_tree().create_tween()
	tween.set_parallel(true)

	tween.tween_property(wheel, "position", Vector2.ZERO, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(wheel, "scale", Vector2.ONE, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(outer_ring, "rotation", 0.0, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(middle_ring, "rotation", 0.0, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(inner_ring, "rotation", 0.0, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(center, "rotation", 0.0, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(dead_center, "rotation", 0.0, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	
	tween.finished.connect(func():
		await get_tree().create_timer(0.25).timeout
		movelevel()
	)


func _on_level_button_mouse_entered() -> void:
	level_select.modulate = Color("ffffff")
	$Hover.play()
func _on_level_button_mouse_exited() -> void:
	level_select.modulate = Color("c1c1c1")

func movelevel() -> void:
	get_tree().change_scene_to_file("res://Scenes/levels/level_1.tscn")


func _on_level_button_pressed() -> void:
	$Select.play()
	pass # Replace with function body.

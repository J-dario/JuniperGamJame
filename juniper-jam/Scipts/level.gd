extends Node2D

@export var num_absolves: int
@export var num_turns: int
@export var stars: int = 3
@onready var label: Label = $Label
@onready var starsContainer: Node2D = $UI/Stars
@onready var starsSFX: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

@onready var outer_ring: Node2D = $Wheel/OuterRing
@onready var middle_ring: Node2D = $Wheel/MiddleRing
@onready var inner_ring: Node2D = $Wheel/InnerRing
@onready var wheel: Node2D = $Wheel
@onready var ui: Node2D = $UI
@onready var audio_stream_player_2d_3: AudioStreamPlayer2D = $Wheel/AudioStreamPlayer2D3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui.modulate.a = 0.0
	GlobalMusic.play_music_level()
	fade_in_UI()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = str(Globals.canMove)
	

func fade_in_UI() -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(ui, "modulate:a", 1.0, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	
	tween.finished.connect(func():
		await get_tree().create_timer(0.25).timeout
		Globals.canMove = true
	)

# add success ding and fail sound before waiting .2 seconds and restartind or moving
func check_win() -> void:
	var rings = [outer_ring, middle_ring, inner_ring]
	for ring in rings:
		var slices_node = ring.get_node("Slices")
		for i in range(1, 7):
			var slice = slices_node.get_node("Slice%d" % i)
			if not slice.isGood:
				#if stars == 0 and num_turns == 0 and num_absolves == 0:
				#	restart()
				return
	wheel.resetRings()

func win() -> void:
	Globals.nextLevel += 1
	Globals.numberStars += stars
	
	var tween := get_tree().create_tween()
	tween.set_parallel(true)

	tween.tween_property(outer_ring, "rotation", 0.0, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(middle_ring, "rotation", 0.0, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(inner_ring, "rotation", 0.0, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	
	for star in starsContainer.get_children():
		if !star.used:
			var star_tween := get_tree().create_tween()
			star_tween.tween_property(star, "position", Vector2(-260, 215), 0.8).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
			starsSFX.play()
			await get_tree().create_timer(0.1).timeout
		
	tween.finished.connect(func():
		await get_tree().create_timer(0.25).timeout
		var path = "res://Scenes/levels/level_%d.tscn" % Globals.nextLevel
		get_tree().change_scene_to_file(path)
	)

func restart() -> void:
	Globals.canMove = false
	$Wheel/AbsolverLeft.deselect()
	$Wheel/AbsolverMiddle.deselect()
	$Wheel/AbsolverRight.deselect()
	$Wheel/OuterRing.unhighlightRing()
	$Wheel/MiddleRing.unhighlightRing()
	$Wheel/InnerRing.unhighlightRing()
	
	if outer_ring.rotation == 0.0 and middle_ring.rotation == 0.0 and inner_ring.rotation == 0.0:
		get_tree().reload_current_scene()
		return
	
	var tween := get_tree().create_tween()
	tween.set_parallel(true)

	audio_stream_player_2d_3.play()
	tween.tween_property(outer_ring, "rotation", 0.0, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(middle_ring, "rotation", 0.0, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(inner_ring, "rotation", 0.0, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	
	tween.finished.connect(func():
		await get_tree().create_timer(0.25).timeout
		get_tree().reload_current_scene()
	)

func _on_button_pressed() -> void:
	$Button/Select.play()
	restart()

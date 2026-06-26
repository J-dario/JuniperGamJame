extends Node2D

@onready var outer_ring: Node2D = $OuterRing
@onready var middle_ring: Node2D = $MiddleRing
@onready var inner_ring: Node2D = $InnerRing
@onready var absolver_left: Node2D = $AbsolverLeft
@onready var absolver_middle: Node2D = $AbsolverMiddle
@onready var c: Node2D = $AbsolverRight

func playUpSound() -> void:
	$AudioStreamPlayer2D2.play()

func playDownSound() -> void:
	$AudioStreamPlayer2D.play()

func resetRings() -> void:
	$AudioStreamPlayer2D5.play()
	$AudioStreamPlayer2D3.play()
	absolver_left.deselect()
	absolver_middle.deselect()
	absolver_middle.deselect()
	
	var tween := get_tree().create_tween()
	tween.set_parallel(true)

	tween.tween_property(outer_ring, "rotation", 0.0, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(middle_ring, "rotation", 0.0, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(inner_ring, "rotation", 0.0, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	
	tween.finished.connect(func():
		await get_tree().create_timer(0.25).timeout
		get_parent().win()
	)

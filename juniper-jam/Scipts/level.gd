extends Node2D

@export var num_absolves: int
@export var num_turns: int
@export var stars: int = 3

@onready var outer_ring: Node2D = $Wheel/OuterRing
@onready var middle_ring: Node2D = $Wheel/MiddleRing
@onready var inner_ring: Node2D = $Wheel/InnerRing

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.canMove = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func check_win() -> void:
	var rings = [outer_ring, middle_ring, inner_ring]
	for ring in rings:
		var slices_node = ring.get_node("Slices")
		for i in range(1, 7):
			var slice = slices_node.get_node("Slice%d" % i)
			if not slice.isGood:
				if stars == 0 and num_turns == 0 and num_absolves == 0:
					restart()
				return
	win()

func win() -> void:
	Globals.nextLevel += 1
	Globals.numberStars += stars

	var path = "res://Scenes/levels/level_%d.tscn" % Globals.nextLevel
	get_tree().change_scene_to_file(path)

func restart() -> void:
	get_tree().reload_current_scene()

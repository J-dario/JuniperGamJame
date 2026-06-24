extends Node2D

enum SelectedMode {
	NONE,
	RING,
	ABSOLVE
}
var selected_mode: SelectedMode = SelectedMode.NONE

var selected_ring_arr = []
var selected_ring_index: int = 1
var selected_ring

var selected_absolver_arr = []
var selected_absolver_index: int = 1
var selected_absolver

func _ready() -> void:
	selected_ring_arr = [
		$"../InnerRing",
		$"../MiddleRing",
		$"../OuterRing"
	]
	selected_ring = selected_ring_arr[selected_ring_index]
	
	selected_absolver_arr = [
		$"../AbsolverLeft",
		$"../AbsolverMiddle",
		$"../AbsolverRight"
	]
	selected_absolver = selected_absolver_arr[selected_absolver_index]

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("SwitchToSpin") and selected_mode != SelectedMode.RING:
		selected_mode = SelectedMode.RING
		selected_ring.highlightRing()
		selected_absolver.deselect()
	
	elif Input.is_action_just_pressed("SwitchToAbsolve") and selected_mode != SelectedMode.ABSOLVE:
		selected_mode = SelectedMode.ABSOLVE
		selected_ring.unhighlightRing()
		selected_absolver.select()

	elif Input.is_action_just_pressed("MoveSelectUp"):
		if selected_mode == SelectedMode.RING:
			var new_index = (selected_ring_index + 1) % selected_ring_arr.size()
			update_selected_ring(new_index)

	elif Input.is_action_just_pressed("MoveSelectDown"):
		if selected_mode == SelectedMode.RING:
			var new_index = (selected_ring_index - 1 + selected_ring_arr.size()) % selected_ring_arr.size()
			update_selected_ring(new_index)
	
	elif Input.is_action_just_pressed("MoveSelectLeft"):
		if selected_mode == SelectedMode.RING:
			selected_ring.rotateLeft()
			
		elif selected_mode == SelectedMode.ABSOLVE:
			var new_index = (selected_absolver_index - 1 + selected_absolver_arr.size()) % selected_absolver_arr.size()
			update_selected_absolver(new_index)
		
	elif Input.is_action_just_pressed("MoveSelectRight"):
		if selected_mode == SelectedMode.RING:
			selected_ring.rotateRight()
			
		elif selected_mode == SelectedMode.ABSOLVE:
			var new_index = (selected_absolver_index + 1) % selected_absolver_arr.size()
			update_selected_absolver(new_index)

func update_selected_ring(new_index: int) -> void:
	var prev_ring = selected_ring_arr[selected_ring_index]
	prev_ring.unhighlightRing()

	selected_ring_index = new_index
	selected_ring = selected_ring_arr[selected_ring_index]
	selected_ring.highlightRing()

func update_selected_absolver(new_index: int) -> void:
	var prev_absolver = selected_absolver_arr[selected_absolver_index]
	prev_absolver.deselect()

	selected_absolver_index = new_index
	selected_absolver = selected_absolver_arr[selected_absolver_index]
	selected_absolver.select()

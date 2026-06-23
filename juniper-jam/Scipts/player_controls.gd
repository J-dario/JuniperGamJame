extends Node2D

enum SelectedMode {
	RING,
	ABSOLVE
}
var selected_mode: SelectedMode = SelectedMode.RING

var selected_ring_arr = []
var selected_ring_index: int = 0
var selected_ring

func _ready() -> void:
	selected_ring_arr = [
		$"../InnerCircle",
		$"../MiddleCircle",
		$"../OuterCircle"
	]
	selected_ring = selected_ring_arr[selected_ring_index]

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("SwitchToSpin") and selected_mode != SelectedMode.RING:
		selected_mode = SelectedMode.RING
		print("Switched To Ring Mode")

	elif Input.is_action_just_pressed("SwitchToAbsolve") and selected_mode != SelectedMode.ABSOLVE:
		selected_mode = SelectedMode.ABSOLVE
		print("Switched To Absolve Mode")

	elif Input.is_action_just_pressed("MoveSelectLeft"):
		if selected_mode == SelectedMode.RING:
			pass
			
		elif selected_mode == SelectedMode.ABSOLVE:
			pass
		
	elif Input.is_action_just_pressed("MoveSelectRight"):
		if selected_mode == SelectedMode.RING:
			pass
			
		elif selected_mode == SelectedMode.ABSOLVE:
			pass

	elif Input.is_action_just_pressed("MoveSelectUp"):
		if selected_mode == SelectedMode.RING:
			var new_index = (selected_ring_index + 1) % selected_ring_arr.size()
			update_selected_ring(new_index)
		
		elif selected_mode == SelectedMode.ABSOLVE:
			pass

	elif Input.is_action_just_pressed("MoveSelectDown"):
		if selected_mode == SelectedMode.RING:
			var new_index = (selected_ring_index - 1 + selected_ring_arr.size()) % selected_ring_arr.size()
			update_selected_ring(new_index)
		
		elif selected_mode == SelectedMode.ABSOLVE:
			pass

func update_selected_ring(new_index: int) -> void:
	var prev_ring = selected_ring_arr[selected_ring_index]
	prev_ring.material.set_shader_parameter("thickness", 0)

	selected_ring_index = new_index
	selected_ring = selected_ring_arr[selected_ring_index]
	selected_ring.material.set_shader_parameter("thickness", 3)

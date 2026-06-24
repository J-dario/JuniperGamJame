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

func _ready() -> void:
	selected_ring_arr = [
		$"../InnerRing",
		$"../MiddleRing",
		$"../OuterRing"
	]

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		$"../InnerRing".highlightRing()
		
	if Input.is_action_just_pressed("SwitchToSpin") and selected_mode != SelectedMode.RING:
		selected_mode = SelectedMode.RING
		selected_ring = selected_ring_arr[selected_ring_index]
		selected_ring.get_node("OutlineRing").material.set_shader_parameter("thickness", 3)
			
		print("Switched To Ring Mode")
	
	elif Input.is_action_just_pressed("SwitchToAbsolve") and selected_mode != SelectedMode.ABSOLVE:
		selected_mode = SelectedMode.ABSOLVE
		selected_ring = selected_ring_arr[selected_ring_index]
		selected_ring.get_node("OutlineRing").material.set_shader_parameter("thickness", 0)
		
		print("Switched To Absolve Mode")
	
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

	elif Input.is_action_just_pressed("MoveSelectLeft"):
		if selected_mode == SelectedMode.RING:
			selected_ring.rotation += deg_to_rad(-60)
			
		elif selected_mode == SelectedMode.ABSOLVE:
			pass
		
	elif Input.is_action_just_pressed("MoveSelectRight"):
		if selected_mode == SelectedMode.RING:
			selected_ring.rotation += deg_to_rad(60)
			
		elif selected_mode == SelectedMode.ABSOLVE:
			pass

func update_selected_ring(new_index: int) -> void:
	var prev_ring = selected_ring_arr[selected_ring_index].get_node("OutlineRing")
	prev_ring.material.set_shader_parameter("thickness", 0)

	selected_ring_index = new_index
	selected_ring = selected_ring_arr[selected_ring_index]
	selected_ring.get_node("OutlineRing").material.set_shader_parameter("thickness", 3)

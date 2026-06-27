extends Node2D

enum SelectedMode {
	NONE,
	RING,
	ABSOLVE,
	RESTART
}
var selected_mode: SelectedMode = SelectedMode.NONE

var selected_ring_arr = []
var selected_ring_index: int = 1
var selected_ring

var selected_absolver_arr = []
var selected_absolver_index: int = 1
var selected_absolver

@onready var vajuses: Node2D = $"../UI/Vajuses"
@onready var stars: Node2D = $"../UI/Stars"
@onready var dharma: Node2D = $"../UI/Dharma"
@onready var wheel: Node2D = $"../Wheel"

func _ready() -> void:
	selected_ring_arr = [
		$"../Wheel/InnerRing",
		$"../Wheel/MiddleRing",
		$"../Wheel/OuterRing"
	]
	selected_ring = selected_ring_arr[selected_ring_index]
	
	selected_absolver_arr = [
		$"../Wheel/AbsolverLeft",
		$"../Wheel/AbsolverMiddle",
		$"../Wheel/AbsolverRight"
	]
	selected_absolver = selected_absolver_arr[selected_absolver_index]
	
	print(get_parent().num_absolves)

func _process(delta: float) -> void:
	if Globals.canMove == false:
		return
	
	elif Input.is_action_just_pressed("Restart"):
		selected_mode = SelectedMode.RESTART
		get_parent()._on_button_mouse_entered()
		$"PickupCoin(4)".play()
		selected_absolver.deselect()
		selected_ring.unhighlightRing()
	
	elif Input.is_action_just_pressed("SwitchToSpin") and selected_mode != SelectedMode.RING:
		selected_mode = SelectedMode.RING
		selected_ring.highlightRing()
		selected_absolver.deselect()
		wheel.playDownSound()
		get_parent()._on_button_mouse_exited()
	
	elif Input.is_action_just_pressed("SwitchToAbsolve") and selected_mode != SelectedMode.ABSOLVE:
		selected_mode = SelectedMode.ABSOLVE
		selected_ring.unhighlightRing()
		selected_absolver.select()
		wheel.playDownSound()
		get_parent()._on_button_mouse_exited()

	elif Input.is_action_just_pressed("MoveSelectUp"):
		if selected_mode == SelectedMode.RING:
			var new_index = (selected_ring_index + 1) % selected_ring_arr.size()
			update_selected_ring(new_index)
			wheel.playUpSound()

	elif Input.is_action_just_pressed("MoveSelectDown"):
		if selected_mode == SelectedMode.RING:
			var new_index = (selected_ring_index - 1 + selected_ring_arr.size()) % selected_ring_arr.size()
			update_selected_ring(new_index)
			wheel.playDownSound()
	
	elif Input.is_action_just_pressed("MoveSelectLeft"):
		if selected_mode == SelectedMode.RING:
			if (get_parent().num_turns != 0 or get_parent().stars != 0):
				if get_parent().num_turns != 0:
					get_parent().num_turns -= 1
					selected_ring.rotateLeft()
					
					for wheel in dharma.get_children():
						if not wheel.used:
							wheel.used = true
							wheel.usedAnim()
							break
				
				elif get_parent().stars != 0:
					get_parent().stars -= 1
					selected_ring.rotateLeft()
				
					for star in stars.get_children():
						if not star.used:
							star.used = true
							star.usedAnim()
							break
				
			elif get_parent().stars == 0:
				$"HitHurt(4)".play()
				$"../Wheel/Camera2D".trigger_small_shake()
			
		elif selected_mode == SelectedMode.ABSOLVE:
			var new_index = (selected_absolver_index - 1 + selected_absolver_arr.size()) % selected_absolver_arr.size()
			update_selected_absolver(new_index)
			wheel.playUpSound()
		
	elif Input.is_action_just_pressed("MoveSelectRight"):
		if selected_mode == SelectedMode.RING:
			if (get_parent().num_turns != 0 or get_parent().stars != 0):
				if get_parent().num_turns != 0:
					get_parent().num_turns -= 1
					selected_ring.rotateRight()
					
					for wheel in dharma.get_children():
						if not wheel.used:
							wheel.used = true
							wheel.usedAnim()
							break
				
				elif get_parent().stars != 0:
					get_parent().stars -= 1
					selected_ring.rotateRight()
				
					for star in stars.get_children():
						if not star.used:
							star.used = true
							star.usedAnim()
							break
			elif get_parent().stars == 0:
				$"HitHurt(4)".play()
				$"../Wheel/Camera2D".trigger_small_shake()
			
		elif selected_mode == SelectedMode.ABSOLVE:
			var new_index = (selected_absolver_index + 1) % selected_absolver_arr.size()
			update_selected_absolver(new_index)
			wheel.playUpSound()
	
	elif Input.is_action_just_pressed("Confirm"):
		
		if selected_mode == SelectedMode.RESTART:
			get_parent().restart()
		
		if selected_mode == SelectedMode.ABSOLVE and (get_parent().num_absolves != 0 or get_parent().stars != 0):
			if get_parent().num_absolves != 0:
				get_parent().num_absolves -= 1
				selected_absolver.absolve()
			
				for vajra in vajuses.get_children():
					if not vajra.used:
						vajra.used = true
						vajra.usedAnim()
						break
			elif get_parent().stars != 0:
				get_parent().stars -= 1
				selected_absolver.absolve()
			
				for star in stars.get_children():
					if not star.used:
						star.used = true
						star.usedAnim()
						break
		elif get_parent().stars == 0:
			$"HitHurt(4)".play()
			$"../Wheel/Camera2D".trigger_small_shake()

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

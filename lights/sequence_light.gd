extends Resource
class_name SequenceLight

signal unstabilized(current_status)

enum Hue {
	RED
	GREEN
	BLUE
}

enum Status {
	OFF = 0,
	ON = 1,
	BLINKING = 2
}

export(Hue) var hue = Hue.RED
export(Status) var current_status = Status.OFF
var inputs = []

func get_status(status: int):
	match status:
		0: return Status.OFF
		1: return Status.ON
		2: return Status.BLINKING

func get_current_status():
	return current_status

func get_input(status: int):
	return inputs[status]
		
func get_current_input():
	return inputs[current_status]

func get_input_length():
	return Status.size()

func generate(lever_states: Array):
	var available_states = []
	
	for lever_state in lever_states:
		available_states.append(lever_state.lever_a_id)
		available_states.append(lever_state.lever_b_id)
		
	var generation_lever_states = available_states

	inputs = []

	for i in range(0, Status.size()):
		randomize()

		var index = round(rand_range(0, generation_lever_states.size() - 1))
		var state = generation_lever_states[index]
		generation_lever_states.erase(state)

		inputs.append(state)

func unstabilize():
	randomize()
	current_status = round(rand_range(0, Status.size() - 1))
	emit_signal("unstabilized", current_status)

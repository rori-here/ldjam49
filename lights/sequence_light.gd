extends Resource
class_name SequenceLight

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
	inputs = []
	print(lever_states)
	for i in range(0, Status.size()):
		randomize()
		var index = round(rand_range(0, lever_states.size() - 1))
		var lever_state = lever_states[index]
		var a_or_b = round(rand_range(0, 1))
		
		if a_or_b == 0:
			inputs.append(lever_state.lever_a_id)
		else:
			inputs.append(lever_state.lever_b_id)

func unstabilize():
	randomize()
	current_status = round(rand_range(0, Status.size() - 1))

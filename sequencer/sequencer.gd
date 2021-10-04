extends Node
class_name Sequencer

enum SequenceState {
	FAILED
	IN_PROGRESS
	SUCCESSFUL
}
export (Resource) var reactor_resource
onready var reactor: Reactor = reactor_resource

export (Resource) var manual_resource
onready var manual: Manual = manual_resource

onready var sequence_timer = $SequenceTimer

var input_sequence = []

signal input_sequence_changed(sequence)

func _ready():
	yield(manual, "manual_generated")
	sequence_timer.connect("timeout", self, "_on_SequenceTimer_timeout")
	reset()

func reset():
	input_sequence = []
	manual.create_sequence()
	emit_signal("input_sequence_changed", input_sequence)
	sequence_timer.start()

func add_to_sequence(value: String):
	input_sequence.append(value)
	emit_signal("input_sequence_changed", input_sequence)
	
	match is_sequence_match():
		SequenceState.SUCCESSFUL: _on_successful()
		SequenceState.FAILED: _on_failed()
		_: pass

func is_sequence_match():
	if (input_sequence.size() == 0):
		return SequenceState.IN_PROGRESS

	for beat in input_sequence.size():
		var light: SequenceLight = manual.get_lights()[beat]
		var expected = light.get_current_input()
		var input = input_sequence[beat]

		if !input:
			 return SequenceState.IN_PROGRESS
	
		if (expected != input):
			return SequenceState.FAILED

	if (input_sequence.size() == manual.get_lights_length()):
		return SequenceState.SUCCESSFUL
	else:
		return SequenceState.IN_PROGRESS

func _on_SequenceTimer_timeout():
	reactor.heat()
	reset()
	
func _on_successful():
	reactor.cool()
	reset()

func _on_failed():
	reactor.heat()
	reset()

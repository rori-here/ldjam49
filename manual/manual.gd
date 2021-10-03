extends Resource
class_name Manual

signal manual_opened
signal manual_closed
signal manual_generated
signal sequence_changed(sequence)

export(Array, Resource) var lever_states = []
var sequence_lights = []

func setup(sls: Array):
	sequence_lights = sls

func generate():
	for light in sequence_lights:
		light.generate(lever_states)
	
	emit_signal("manual_generated")

func create_sequence():
	for light in sequence_lights:
		light.unstabilize()
	
	emit_signal("sequence_changed", get_lights())

func get_lights():
	return sequence_lights

func get_lights_length():
	return sequence_lights.size()

func open_manual():
	emit_signal("manual_opened")

func close_manual():
	emit_signal("manual_closed")

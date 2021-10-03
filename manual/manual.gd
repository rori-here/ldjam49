extends Resource
class_name Manual

signal manual_generated
signal sequence_changed(sequence)

export(Array, Resource) var lever_states = []
export(Array, Resource) var sequence_lights = []


func generate():
	for light in sequence_lights:
		light.generate(lever_states)
	
	emit_signal("manual_generated")
	print("Generated")

func create_sequence():
	for light in sequence_lights:
		light.unstabilize()
		
	emit_signal("sequence_changed", get_lights())
	print("Sequenced")

func get_lights():
	return sequence_lights

func get_lights_length():
	return sequence_lights.size()

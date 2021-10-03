extends Node
class_name SequenceFactory

export(Array, Resource) var lever_states = []
export(Array, Resource) var sequence_lights = []

func _ready():
	generate_manual()
	
func get_sequence_length():
	return sequence_lights.size()

func generate_manual():
	for light in sequence_lights:
		light.generate(lever_states)
		
func create_sequence():
	for light in sequence_lights:
		light.unstabilize()
		
	return sequence_lights

extends Node

export (Resource) var manual_resource
onready var manual: Manual = manual_resource

func _ready():
	var lights = get_tree().get_nodes_in_group("lights")
	var sequence_lights = []

	for light in lights:
		yield(light, "ready")
		if (light.has_method("get_sequence_light")):
			sequence_lights.append(light.get_sequence_light())

	manual.setup(sequence_lights)
	manual.generate()

func get_available_sequence_lights():
	var lights =  get_available_lights()
	var sequence_lights = []
	
	for light in lights:
		if (light.has_method("get_sequence_light")):
			sequence_lights.append(light.get_sequence_light())
	
	return sequence_lights

func get_available_lights():
	return 


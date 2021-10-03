extends Node

export (Resource) var manual_resource
onready var manual: Manual = manual_resource
var sequence_lights = []

func _ready():
	var lights = get_tree().get_nodes_in_group("lights")
	sequence_lights = []

	for light in lights:
		yield(light, "ready")
		if (light.has_method("get_sequence_light")):
			sequence_lights.append(light.get_sequence_light())

	manual.setup(sequence_lights)
	manual.generate()



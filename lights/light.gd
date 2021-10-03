extends Node


export (Resource) var manual_resource
onready var manual: Manual = manual_resource

export (Resource) var sequence_light_resource
onready var sequence_light: SequenceLight = sequence_light_resource

func _ready():
	sequence_light.connect("unstabilized", self, "_on_unstabilized")
	
func _on_unstabilized(status):
	var animation = "{hue}_{status}".format({
		"hue": SequenceLight.Hue.keys()[sequence_light.hue],
		"status": SequenceLight.Status.keys()[status]
	})
	
	$AnimationPlayer.play(animation.to_lower())

func get_sequence_light():
	return sequence_light

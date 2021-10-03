extends Node


export (Resource) var manual_resource
onready var manual: Manual = manual_resource

export (Resource) var light_resource
onready var light: SequenceLight = light_resource

func _ready():
	_on_sequence_changed()
	manual.connect("sequence_changed", self, "_on_sequence_channged")
	
func _on_sequence_changed():
	var animation = "{hue}_{status}".format({
		"hue": SequenceLight.Hue.keys()[light.hue],
		"status": SequenceLight.Status.keys()[light.get_current_status()]
	})
	
	$AnimationPlayer.play(animation.to_lower())

func get_attached_light():
	return light

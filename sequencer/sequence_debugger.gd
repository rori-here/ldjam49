extends Label
class_name SequenceDebugger

export(Resource) var manual_resource
onready var manual: Manual = manual_resource
var initialText = self.text

func _ready():
	manual.connect("sequence_changed", self, "_on_sequence_changed")

func _on_sequence_changed(sequence: Array):
	var sequenceText = ''

	if sequence.size() > 0:
		for i in range(0, sequence.size()):
			var item = sequence[i]
			sequenceText += str(item.get_current_input())
			
	else:
		sequenceText = "none"
		
	text = initialText.format({
		"sequence": sequenceText
	})

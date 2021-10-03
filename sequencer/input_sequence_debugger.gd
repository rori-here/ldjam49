extends Label
class_name InputSequencerDebugger

var initialText = self.text

func _ready():
	_on_Sequencer_input_sequence_changed([])

func _on_Sequencer_input_sequence_changed(sequence: Array):
	var sequenceText = ''

	if sequence.size() > 0:
		for i in range(0,sequence.size()):
			var item = sequence[i]
			sequenceText += str(item)
	else:
		sequenceText = "none"
		
	text = initialText.format({
		"sequence": sequenceText
	})

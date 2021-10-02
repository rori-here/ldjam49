extends Label
class_name StateMachineDebugger

var initialText = self.text

func _on_StateMachine_transitioned(state_name):
	text = initialText.format({"state": state_name})

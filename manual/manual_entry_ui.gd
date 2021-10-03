extends Panel

onready var label = $Label

func display(light: SequenceLight, status):
	$Label.text = light.get_input(status)

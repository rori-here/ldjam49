extends Interactable
class_name LeverInteractable

signal lever_pull

func _ready():
	$Interactable.hide()

func interact():
	emit_signal("lever_pull")
	emit_signal("close_interaction")
	
func interactable(status):
	if status:
		$Interactable.show()
	else:
		$Interactable.hide()

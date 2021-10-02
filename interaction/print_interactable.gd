extends Interactable
class_name PrintInteractable

func interact():
	print("Print Interactable")
	emit_signal("close_interaction")

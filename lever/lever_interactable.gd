extends Interactable
class_name LeverInteractable

signal lever_pull

func interact():
	print("Lever Interactable")
	emit_signal("lever_pull")
	emit_signal("close_interaction")

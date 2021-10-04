extends Interactable
class_name LeverInteractable

signal lever_pull

func _ready():
	$InteractableSprite.hide()

func interact():
	emit_signal("lever_pull")
	emit_signal("close_interaction")
	
func interactable(status):
	if status:
		$InteractableSprite.show()
	else:
		$InteractableSprite.hide()

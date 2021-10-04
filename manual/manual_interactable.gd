extends Interactable
class_name ManualInteractable

export (Resource) var manual_resource
onready var manual: Manual = manual_resource
onready var interactable_sprite = $InteractableSprite

func _ready():
	interactable_sprite.hide()
	manual.connect("manual_closed", self, "_on_manual_closed")

func interact():
	manual.open_manual()

func _on_manual_closed():
	emit_signal("close_interaction")

func interactable(status):
	if status:
		interactable_sprite.show()
	else:
		interactable_sprite.hide()

extends Interactable
class_name ManualInteractable

export (Resource) var manual_resource
onready var manual: Manual = manual_resource

func _ready():
	manual.connect("manual_closed", self, "_on_manual_closed")

func interact():
	manual.open_manual()

func _on_manual_closed():
	emit_signal("close_interaction")

extends GridContainer

export(Resource) var manual_resource
onready var manual: Manual = manual_resource

const manual_top_head_ui = preload("res://manual/ManualTopHeadUI.tscn")

func _ready():
	_on_manual_changed()
	manual.connect("manual_changed", self, "_on_manual_changed")
	manual.connect("manual_generated", self, "_on_manual_changed")

func _on_manual_changed():
	for obj in get_children():
		remove_child(obj)
		obj.queue_free()
	
	for status in SequenceLight.Status:
		var slot = manual_top_head_ui.instance()
		add_child(slot)
		slot.display(status)	

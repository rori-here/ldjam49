extends Control

export(Resource) var manual_resource
onready var manual: Manual = manual_resource

const manual_entry_ui = preload("res://manual/ManualEntryUI.tscn")

func _ready():
	_on_manual_changed()
	manual.connect("manual_changed", self, "_on_manual_changed")
	manual.connect("manual_generated", self, "_on_manual_changed")

func _on_manual_changed():
	for obj in get_children():
		remove_child(obj)
		obj.queue_free()
	
	for entry in manual.get_lights():
		var light = entry
		for _i in light.get_input_length(): 
			var slot = manual_entry_ui.instance()
			
			add_child(slot)
			
			slot.display(entry, _i)	

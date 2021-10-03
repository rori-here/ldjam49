extends Control

export (Resource) var manual_resource
onready var manual: Manual = manual_resource

func _ready():
	manual.connect("manual_opened", self, "_on_manual_opened")

func _on_manual_opened():
	self.show()

func _input(event):
	if InputHelper.is_close_manual_just_pressed():
		manual.close_manual()
		self.hide()

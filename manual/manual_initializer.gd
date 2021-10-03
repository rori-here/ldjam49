extends Node

export (Resource) var manual_resource
onready var manual: Manual = manual_resource

func _ready():
	manual.generate()

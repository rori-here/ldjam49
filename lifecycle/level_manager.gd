extends Node

export (Resource) var day_resource
onready var day: Day = day_resource

export (Resource) var reactor_resource
onready var reactor: Reactor = reactor_resource

func _ready():
	day.connect("day_cleared", self, "_on_day_cleared")
	reactor.connect("meltdown", self, "_on_meltdown")

func _on_day_cleared():
	get_tree().change_scene("res://lifecycle/DayClearedScreen.tscn")
	
func _on_meltdown(_level: int):
	get_tree().change_scene("res://lifecycle/MeltdownScreen.tscn")

extends Node
class_name LevelManager

export (Resource) var day_resource
onready var day: Day = day_resource

export (Resource) var reactor_resource
onready var reactor: Reactor = reactor_resource

onready var meltdown_idle_timer = $MeltdownIdleTimer
onready var day_over_idle_timer = $DayOverIdleTimer

func _ready():
	day.connect("day_cleared", self, "_on_day_cleared")
	reactor.connect("meltdown", self, "_on_meltdown")

	meltdown_idle_timer.connect("timeout", self, "_on_meltdown_idle_timeout")
	day_over_idle_timer.connect("timeout", self, "_on_day_over_idle_timeout")

func _on_day_over_idle_timeout():
	get_tree().change_scene("res://lifecycle/DayClearedScreen.tscn")
	
func _on_meltdown_idle_timeout():
	get_tree().change_scene("res://lifecycle/MeltdownScreen.tscn")

func _on_day_cleared():
	day_over_idle_timer.start()
	
func _on_meltdown(_level: int):
	meltdown_idle_timer.start()

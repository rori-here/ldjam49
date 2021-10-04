extends Node
class_name LevelManager

export (Resource) var reactor_resource
onready var reactor: Reactor = reactor_resource

onready var meltdown_idle_timer = $MeltdownIdleTimer
onready var stabilized_idle_timer = $StabilizedIdleTimer

func _ready():
	reactor.connect("stabilized", self, "_on_stabilized")
	reactor.connect("destabilized", self, "_on_destabilized")

	meltdown_idle_timer.connect("timeout", self, "_on_meltdown_idle_timeout")
	stabilized_idle_timer.connect("timeout", self, "_on_stabilized_idle_timeout")

func _on_stabilized_idle_timeout():
	get_tree().change_scene("res://lifecycle/DayClearedScreen.tscn")
	
func _on_meltdown_idle_timeout():
	get_tree().change_scene("res://lifecycle/MeltdownScreen.tscn")

func _on_stabilized():
	stabilized_idle_timer.start()
	
func _on_destabilized():
	meltdown_idle_timer.start()

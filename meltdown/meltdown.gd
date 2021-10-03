extends Timer
class_name Meltdown

export (Resource) var reactor_resource
onready var reactor: Reactor = reactor_resource

func _on_Meltdown_timeout():
	reactor.melt()

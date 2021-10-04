extends Control

export (Resource) var reactor_resource
onready var reactor: Reactor = reactor_resource
onready var meltdown_label = $MeltdownLabel
onready var stabilized_label = $StabilizedLabel

func _ready():
	meltdown_label.hide()
	stabilized_label.hide()
	reactor.connect("destabilized", self, "_on_destabilized")
	reactor.connect("stabilized", self, "_on_stabilized")

func _on_destabilized():
	meltdown_label.show()

func _on_stabilized():
	stabilized_label.show()

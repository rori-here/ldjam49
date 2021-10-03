extends Control
class_name MeltdownUI

export (Resource) var reactor_resource
onready var reactor: Reactor = reactor_resource
onready var reactor_label = $ReactorLabel
onready var reactor_label_initial_text = $ReactorLabel.text

func _ready():
	reactor.connect("penalized", self, "_on_penalized")
	reactor.connect("melt", self, "_on_melt")
	set_text(reactor.level)

func _on_penalized(amount: int, level: int):
	set_text(level)
	
func _on_melt(rate: int, level: int):
	set_text(level)
	
func set_text(level: int):
	 reactor_label.text = reactor_label_initial_text.format({
		"level": level
	})

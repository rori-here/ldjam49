extends Control
class_name MeltdownUI

export (Resource) var reactor_resource
onready var reactor: Reactor = reactor_resource
onready var reactor_label = $ReactorLabel
onready var reactor_label_initial_text = $ReactorLabel.text

func _ready():
	reactor.connect("cooled", self, "_on_cooled")
	reactor.connect("heated", self, "_on_heated")
	reactor.connect("melted", self, "_on_melted")
	set_text(reactor.level)

func _on_cooled(_heat: int, level: int):
	set_text(level)

func _on_heated(_heat: int, level: int):
	set_text(level)
	
func _on_melted(_rate: int, level: int):
	set_text(level)
	
func set_text(level: int):
	 reactor_label.text = reactor_label_initial_text.format({
		"level": level
	})

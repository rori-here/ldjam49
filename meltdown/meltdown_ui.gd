extends Control
class_name MeltdownUI

export (Resource) var reactor_resource
onready var reactor: Reactor = reactor_resource
onready var animation_player = $AnimationPlayer
onready var reactor_progress = $Panel/ReactorProgress
onready var melt_label = $Panel/Melt
onready var cool_label = $Panel/Cool
onready var melt_label_initial_text = melt_label.text
onready var cool_label_initial_text = cool_label.text

func _ready():
	melt_label.visible = false
	cool_label.visible = false
	reactor.connect("cooled", self, "_on_cooled")
	reactor.connect("heated", self, "_on_heated")
	reactor.connect("melted", self, "_on_melted")
	set_progress(reactor.level)

func _on_cooled(cool: int, level: int):
	set_progress(level)
	set_cool(cool)
	animation_player.play("cool")

func _on_heated(heat: int, level: int):
	set_progress(level)
	set_heat(heat)
	animation_player.play("heat")
	
func _on_melted(_rate: int, level: int):
	set_progress(level)

func set_progress(level: int):
	reactor_progress.value = level
	
func set_heat(heat):
	melt_label.text = melt_label_initial_text.format({
		"heat": heat
	})

func set_cool(cool):
	cool_label.text = cool_label_initial_text.format({
		"cool": cool
	})

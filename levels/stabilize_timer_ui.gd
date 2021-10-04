extends CenterContainer

export (Resource) var reactor_resource
onready var reactor: Reactor = reactor_resource

onready var stabilize_label = $Panel/StabilizeLabel
onready var stabilize_label_initial_text = stabilize_label.text

func _ready():
	set_text(reactor.get_time())
	reactor.connect("reactor_tick", self, "_on_reactor_tick")

func _on_reactor_tick(time: int):
	set_text(time)
	
func set_text(time: int):
	var mm = round(time / 60)
	var ss = time % 60
	
	stabilize_label.text = "%02d:%02d" % [mm,ss]

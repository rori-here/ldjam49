extends Control
class_name MeltdownUI

const STABILIZE_STATE_UI = preload("res://meltdown/StabilizeStateUI.tscn")

export (Resource) var reactor_resource
onready var reactor: Reactor = reactor_resource
onready var animation_player = $AnimationPlayer
onready var reactor_progress = $Panel/ReactorProgress
onready var stable_status_label = $Panel/StableStatus
onready var stabilize_states = $Panel/StabilizeStates
onready var stable_status_label_initial_text = stable_status_label.text

func _ready():
	stable_status_label.visible = false
	stabilize_states.columns = reactor.stabilize_checks_required

	reactor.connect("stabilize", self, "_on_stabilize")
	reactor.connect("destabilize", self, "_on_destabilize")
	reactor.connect("destabilized", self, "_on_destabilized")
	
	set_progress(reactor.level)
	display_stabilizer_states()

func display_stabilizer_states():
	for stabilize_state in stabilize_states.get_children():
		remove_child(stabilize_state)
		stabilize_state.queue_free()

	for index in range(0, reactor.stabilize_checks_required):
		var stabilize_state = STABILIZE_STATE_UI.instance()
		var state = reactor.get_stabilize_check_state(index)
		stabilize_state.display_state(reactor.get_stabilize_check_state(index))
		
		stabilize_states.add_child(stabilize_state)
	
func _on_stabilize(cool: int, level: int):
	set_progress(level)
	set_stable_status_label(cool)
	display_stabilizer_states()
	animation_player.play("poof")

func _on_destabilize(penalty: int, level: int):
	set_progress(level)
	set_stable_status_label(penalty)
	display_stabilizer_states()
	animation_player.play("poof")

func _on_destabilized(level: int):
	set_progress(level)

func set_progress(level: int):
	reactor_progress.value = level

func set_stable_status_label(value):
	stable_status_label.text = stable_status_label_initial_text.format({
		"value": value
	})

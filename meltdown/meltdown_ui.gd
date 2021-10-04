extends Control
class_name MeltdownUI

const STABILIZE_STATE_UI = preload("res://meltdown/StabilizeStateUI.tscn")

export (Resource) var reactor_resource
onready var reactor: Reactor = reactor_resource
onready var animation_player = $AnimationPlayer
onready var reactor_progress = $Panel/ReactorProgress
onready var stable_status_label = $Panel/StableStatus
onready var stabilize_states = $Panel/StabilizeStates

func _ready():
	stable_status_label.visible = false
	stabilize_states.columns = reactor.stabilize_checks_required

	reactor.connect("stabilize", self, "_on_stabilize")
	reactor.connect("destabilize", self, "_on_destabilize")
	
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
	display_stabilizer_states()
	animation_player.play("poof")

func _on_destabilize(penalty: int, level: int):
	set_progress(level)
	display_stabilizer_states()
	animation_player.play("poof")

func set_progress(level: int):
	reactor_progress.value = level

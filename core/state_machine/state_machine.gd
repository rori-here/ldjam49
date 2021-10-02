extends Node
class_name StateMachine

signal transitioned(state_name)

var state = null

func _ready():
	yield(owner, "ready")
	
	for child in get_children():
		if(child.has_method("setup")):
			child.setup(self)
	
	var initial_state = get_child(0)
	
	if (!initial_state):
		printerr("You forgot to set the state of a state machine.")
		
	state = initial_state
	
	state.enter()

func _process(delta):
	state.process(delta)
	
func _physics_process(delta):
	state.physics_process(delta)

func transition(target_state_name: String, msg: Dictionary = {}) -> void:
	if !has_node(target_state_name):
		return

	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)

	emit_signal("transitioned", state.name)

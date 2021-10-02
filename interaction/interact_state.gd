extends PlayerState
class_name InteractState

var current_collider: Interactable
var is_interacting = false
var is_processing = false

func _ready():
	yield(owner, "ready")

func enter(_msg = {}) -> void:
	is_processing = true

func exit() -> void:
	is_processing = false
		
func process(_delta):
	if (current_collider != null):
		if (is_processing && !is_interacting):
			is_interacting = true
			current_collider.interact()
	else:
		get_state_machine().transition("IdleState")

func _on_interact_done():
	is_interacting = false
	get_state_machine().transition("IdleState")

func _on_InteractState_body_entered(collider):
	if (collider is Interactable && collider != current_collider):
		var _connect = collider.connect("close_interaction", self, "_on_interact_done")

		current_collider = collider

func _on_InteractState_body_exited(collider):
	if (collider == current_collider):
		var _connect = collider.disconnect("close_interaction", self, "_on_interact_done")
		current_collider = null

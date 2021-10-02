extends Node
class_name State

var state_machine: StateMachine setget ,get_state_machine

func get_state_machine() -> StateMachine:
	return state_machine

func _ready():
	yield(owner, "ready")

func process(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	pass

func setup(sm: StateMachine):
	if !state_machine:
		state_machine = sm

func enter(_msg := {}) -> void:
	pass

func exit() -> void:
	pass

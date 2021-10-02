extends PlayerState
class_name DashState

var can_dash = true
export var speed = 800
export var acceleration = 2

func enter(_msg: Dictionary = {}) -> void:
	can_dash = true
	player.move(Vector2.ZERO)
	$DurationTimer.start()
	var _connect = $DurationTimer.connect("timeout", self, "block")

func block():
	can_dash = false
	player.move(Vector2.ZERO)
	$TransitionTimer.start()
	var _connect = $TransitionTimer.connect("timeout", self, "finished")

func finished():
	get_state_machine().transition("WalkState")

func process(_delta: float) -> void:
	if !InputHelper.has_movement_input():
		get_state_machine().transition("WalkState")

func physics_process(_delta: float) -> void:
	if can_dash:
		var player = get_player()
		
		var current_input = InputHelper.get_movement_input()
		
		var velocity = lerp(player.get_velocity(), current_input * speed, acceleration)
		
		player.move(velocity)

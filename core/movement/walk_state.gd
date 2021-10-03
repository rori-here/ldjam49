extends PlayerState
class_name WalkState

export var speed = 75
export var acceleration = 1

func process(_delta: float) -> void:
	if !InputHelper.has_movement_input():
		get_state_machine().transition("IdleState")
	
	elif InputHelper.is_interact_just_pressed():
		get_state_machine().transition("InteractState")

func physics_process(delta: float) -> void:
	var player = get_player()
	var current_input = InputHelper.get_movement_input()
	
	var velocity = player.get_velocity()

	velocity.x = lerp(player.get_velocity().x, current_input.x * speed, acceleration)
	velocity.y = lerp(player.get_velocity().y, current_input.y * speed, acceleration)

	player.move(velocity)

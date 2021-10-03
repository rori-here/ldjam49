extends PlayerState
class_name IdleState

export var friction = 0.05

func process(_delta: float) -> void:
	if InputHelper.has_movement_input():
		get_state_machine().transition("WalkState")
		
	elif InputHelper.is_interact_just_pressed():
		get_state_machine().transition("InteractState")

func physics_process(delta: float) -> void:
	var player = get_player()
	var velocity = player.get_velocity()

	velocity.x = lerp(player.get_velocity().x, 0, friction)
	velocity.y = lerp(player.get_velocity().y, 0, friction)

	player.move(velocity)

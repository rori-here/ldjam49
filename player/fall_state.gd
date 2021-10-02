extends PlayerState
class_name FallState

export var friction = 0.001
onready var GRAVITY = -ProjectSettings.get_setting("physics/3d/default_gravity")

func physics_process(delta: float) -> void:
	if (player.is_on_floor()):
		get_state_machine().transition("IdleState")

	var velocity = player.get_velocity()
	
	velocity.y += delta * GRAVITY
	velocity.x = lerp(velocity.x, 0, friction)
	velocity.z = lerp(velocity.z, 0, friction)
	
	player.move(velocity)
	
	if (velocity.y < -5):
		get_state_machine().transition("DieState")

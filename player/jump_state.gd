extends PlayerState
class_name JumpState
export var speed = 2.5
export var friction = 0.001
onready var GRAVITY = -ProjectSettings.get_setting("physics/3d/default_gravity")


func physics_process(delta: float) -> void:
	var player = get_player()

	var current_input = InputHelper.get_movement_input()
	
	var velocity = player.get_velocity()
	velocity.y = speed
	velocity.x = lerp(player.get_velocity().x, 0, friction)
	velocity.z = lerp(player.get_velocity().z, 0, friction)
	
	player.move(velocity)
	
	get_state_machine().transition("FallState")

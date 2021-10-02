extends PlayerState
class_name DieState

func physics_process(delta):
	var collision_shape = player.get_node("CollisionShape2D")
	collision_shape.disabled = true
	player.velocity = Vector2.ZERO
	
	get_state_machine().transition("RespawnState")

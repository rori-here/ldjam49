extends PlayerState
class_name RespawnState

func physics_process(delta):
	var collision_shape = player.get_node("CollisionShape2D")
	player.global_transform.origin = player.spawn_position.global_transform.origin
	collision_shape.disabled = false
	
	get_state_machine().transition("IdleState")

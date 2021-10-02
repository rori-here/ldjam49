extends Node

func is_interact_just_pressed() -> bool:
	return Input.is_action_just_pressed("player_interact")

func get_movement_input() -> Vector2:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("player_move_right") - Input.get_action_strength("player_move_left")
	input_vector.y = Input.get_action_strength("player_move_down") - Input.get_action_strength("player_move_up")
	input_vector = input_vector.normalized()
	return input_vector

func has_movement_input() -> bool:
	return get_movement_input() != Vector2.ZERO

func is_jump_just_pressed():
	return Input.is_action_just_pressed("player_jump")
	

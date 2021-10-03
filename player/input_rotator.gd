extends Node2D

var paused = false
var _movement_vector = Vector2(0, 1)

func _process(delta):
	if !paused:
		var movement_vector = InputHelper.get_movement_input()
		
		if (movement_vector != Vector2.ZERO):
			_movement_vector = movement_vector

		var vector_angle = _movement_vector.angle()
		set_rotation_degrees(rad2deg(vector_angle))

func _on_StateMachine_transitioned(state_name):
	match state_name:
		"InteractState": paused = true
		_: paused = false

extends KinematicBody2D
class_name Player

export(NodePath) var spawn_position_path

var velocity: Vector2 setget ,get_velocity

func _ready() -> void:
	if (!spawn_position_path):
		printerr("You forgot to set the spawn position node.")
		

func get_velocity() -> Vector2:
	return velocity

func move(v: Vector2) -> void:
	velocity = move_and_slide(v)

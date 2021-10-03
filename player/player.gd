extends KinematicBody2D
class_name Player

enum Direction {
	UP
	LEFT
	DOWN
	RIGHT
	UP_RIGHT
	UP_LEFT
	DOWN_RIGHT
	DOWN_LEFT
}

export(NodePath) var spawn_position_path

var dir = Direction.DOWN setget set_dir
var velocity: Vector2 setget ,get_velocity

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite
onready var sprite_side = $SpriteSide

func _ready() -> void:
	if (!spawn_position_path):
		printerr("You forgot to set the spawn position node.")

func get_velocity() -> Vector2:
	return velocity

func set_dir(new_dir):
	dir = new_dir
	set_sprite()
	
func set_sprite():
	if dir == Direction.DOWN:
		sprite_side.hide()
		sprite.show()
	elif dir == Direction.LEFT:
		sprite_side.set_flip_h(true)
		sprite_side.show()
		sprite.hide()
	elif dir == Direction.UP:
		sprite_side.hide()
		sprite.show()
	elif dir == Direction.RIGHT:
		sprite_side.set_flip_h(false)
		sprite_side.show()
		sprite.hide()

func move(v: Vector2) -> void:
	velocity = move_and_slide(v)
	
	var movement_vector = InputHelper.get_movement_input()
	
	if movement_vector == Vector2(0,0): 
		pass
	elif movement_vector == Vector2(1,0): 
		if dir != Direction.RIGHT:
			set_dir(Direction.RIGHT)
	elif movement_vector == Vector2(-1,0): 
		if dir != Direction.LEFT:
			set_dir(Direction.LEFT)
	elif movement_vector == Vector2(0,1): 
		if dir != Direction.DOWN:
			set_dir(Direction.DOWN)
	elif movement_vector == Vector2(0,-1): 
		if dir != Direction.UP:
			set_dir(Direction.UP)

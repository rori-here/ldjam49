extends Node2D

enum LeverState {
	A,
	B,
	Neutral
}

var current_state = LeverState.Neutral
onready var collisionA = $LeverA/CollisionShape2D
onready var collisionB = $LeverB/CollisionShape2D

onready var spriteA = $LeverA/Sprite
onready var spriteB = $LeverB/Sprite

func _on_LeverA_lever_pull():
	current_state = LeverState.A
	collisionA.set_disabled(true)
	collisionB.set_disabled(false)
	spriteA.set_flip_v(true)
	spriteB.set_flip_v(false)

func _on_LeverB_lever_pull():
	current_state = LeverState.B	
	collisionB.set_disabled(true)
	collisionA.set_disabled(false)
	spriteB.set_flip_v(true)
	spriteA.set_flip_v(false)

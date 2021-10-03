extends Node2D

export(NodePath) var sequencer_node_path
export(Resource) var lever_resource

onready var sequencer: Sequencer = get_node(sequencer_node_path)
onready var collisionA = $LeverA/CollisionShape2D
onready var collisionB = $LeverB/CollisionShape2D

onready var spriteA = $LeverA/Sprite
onready var spriteB = $LeverB/Sprite
onready var current_state = lever_resource.lever_n_id

onready var animationPlayer = $AnimationPlayer

var isAnimating: bool = false

func _ready():
	spriteA.texture = lever_resource.texture
	spriteB.texture = lever_resource.texture

func update_sequencer():
	sequencer.add_to_sequence(current_state)

func _on_LeverA_lever_pull():
	if animationPlayer.current_animation == '':
		if current_state == lever_resource.lever_b_id:
			current_state = lever_resource.lever_n_id
			collisionA.set_disabled(false)
			collisionB.set_disabled(false)		
			animationPlayer.play("B-to-N")
		else:
			current_state = lever_resource.lever_a_id
			collisionA.set_disabled(true)
			animationPlayer.play("N-to-A")
			update_sequencer()

func _on_LeverB_lever_pull():
	if animationPlayer.current_animation == '':
		if current_state == lever_resource.lever_a_id:
			current_state = lever_resource.lever_n_id
			collisionA.set_disabled(false)
			collisionB.set_disabled(false)
			animationPlayer.play("A-to-N")
		else:
			current_state = lever_resource.lever_b_id
			collisionB.set_disabled(true)
			animationPlayer.play("N-to-B")
			update_sequencer()

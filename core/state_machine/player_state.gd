extends State
class_name PlayerState

export(NodePath) var player_node

var player: Player setget ,get_player

func get_player() -> Player:
	return player

func _ready():
	yield(owner, "ready")

	if (!player_node):
		printerr("You forgot to set the player node.")
		
	player = get_node(player_node)

	if (!player):
		printerr("Set node is not of type player.")

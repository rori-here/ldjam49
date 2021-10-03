extends Panel

onready var sprite = $Sprite

func display(color: Color):
	sprite.modulate = color

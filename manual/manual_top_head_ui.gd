extends Panel

onready var sprite = $Sprite

func display(state: String):
	match(state):
		"OFF":
			sprite.region_rect = Rect2(0,0,16,16)
		"ON":
			sprite.region_rect = Rect2(16,0,16,16)
		"BLINKING":
			sprite.region_rect = Rect2(32,0,16,16)

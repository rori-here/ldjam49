extends ColorRect
class_name PlayScreen

func _input(event):
	if (event is InputEventKey):
		get_tree().change_scene("res://World.tscn")

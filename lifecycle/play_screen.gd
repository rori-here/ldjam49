extends ColorRect
class_name PlayScreen

func _process(event):
	if (InputHelper.is_ui_accept_just_pressed()):
		get_tree().change_scene("res://tutorial/Tutorial.tscn")

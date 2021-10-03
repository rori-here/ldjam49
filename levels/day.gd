extends Resource
class_name Day

signal day_cleared
signal day_changed(time)

export(int) var time = 180

func get_time():
	return time

func set_time(new_time):
	time = clamp(new_time, 0, time)
	emit_signal("day_changed", time)

func decrease_time(new_time):
	set_time(time - new_time)
	
	if (is_day_cleared()):
		emit_signal("day_cleared")
		
func is_day_cleared():
	return time == 0



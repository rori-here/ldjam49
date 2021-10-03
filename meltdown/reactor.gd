extends Resource
class_name Reactor

signal cooled(cool, level)
signal heated(heat, level)
signal melted(background_rate, level)
signal meltdown(level)

export(int, 0, 100) var level = 0

export(int, 0, 25) var background_rate = 5

export(int, 0, 25) var penalty = 10

export(int, 0, 25) var cool = 20

func is_meltdown():
	return level == 100

func set_level(new_level: int):
	level = clamp(new_level, 0, 100)
	
	if is_meltdown():
		emit_signal("meltdown", level)

func cool():
	set_level(level - cool)
	emit_signal("cooled", cool, level)

func heat():
	set_level(level + penalty)
	emit_signal("heated", penalty, level)

func melt():
	set_level(level + background_rate)
	emit_signal("melted", background_rate, level)

func get_current_level():
	return level

func get_current_background_rate():
	return background_rate

func get_current_penalty():
	return penalty

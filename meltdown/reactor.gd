extends Resource
class_name Reactor

signal stabilized
signal destabilized
signal reactor_tick(time)
signal stabilize(cool, level)
signal destabilize(heat, level)
signal meltdown(level)

enum StabilizeState {
	NEUTRAL,
	DESTABILIZED,
	STABILIZED
}

export(int, 0, 100) var level = 50
export(int, 0, 25) var penalty = 10
export(int, 0, 25) var cool = 20
export(int, 1, 5) var stabilize_checks_required = 5
export(int, 1, 60) var stabilize_time = 30

var time = 0

var stabilize_checks = []

func is_destabilized():
	return level == 100

func is_stabilized():
	return level

func set_level(new_level: int):
	level = clamp(new_level, 0, 100)

func reset_time():
	set_time(stabilize_time)

func set_time(new_time):
	time = clamp(new_time, 0, stabilize_time)
	emit_signal("reactor_tick", time)

func decrease_time(new_time):
	if (time == 0):
		destabilize()
	else:
		set_time(time - new_time)

func stabilize():
	stabilize_checks.append(StabilizeState.STABILIZED)
	set_level(level - cool)
	emit_signal("stabilize", cool, level)
	
	if stabilize_checks.size() == stabilize_checks_required:
		emit_signal("stabilized")

func destabilize():
	stabilize_checks.append(StabilizeState.DESTABILIZED)
	set_level(level + penalty)
	emit_signal("destabilize", penalty, level)

	if(level == 100):
		emit_signal("destabilized")
	elif stabilize_checks.size() == stabilize_checks_required:
		emit_signal("stabilized")

func get_current_level():
	return level

func get_current_penalty():
	return penalty

func get_time():
	return time


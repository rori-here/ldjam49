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

export(int, 0, 50) var penalty = 30

export(int, 0, 50) var cool = 20

export(int, 1, 5) var stabilize_checks_required = 5
export(int, 1, 60) var critical_stabilize_time = 45
export(int, 0, 60) var warning_stabilize_time = 40
export(int, 0, 60) var regular_stabilize_time = 32

var time = 0

var stabilize_checks = []

func is_destabilized():
	return level == 100

func is_stabilized():
	return level

func set_level(new_level: int):
	level = clamp(new_level, 0, 100)

func reset_time():
	set_time(get_stabilize_time())

func set_time(new_time):
	time = clamp(new_time, 0, get_stabilize_time())
	emit_signal("reactor_tick", time)

func decrease_time(new_time):
	if (time == 0):
		destabilize()
	else:
		set_time(time - new_time)

func stabilize():
	stabilize_checks.append(StabilizeState.STABILIZED)
	set_level(level - cool)
	
	if stabilize_checks.size() == stabilize_checks_required:
		emit_signal("stabilized")
	else:
		emit_signal("stabilize", cool, level)

func destabilize():
	stabilize_checks.append(StabilizeState.DESTABILIZED)
	var penalty = get_current_penalty()
	set_level(level + penalty)

	if(level == 100):
		emit_signal("destabilized")
	elif stabilize_checks.size() == stabilize_checks_required:
		emit_signal("stabilized")
	else:
		emit_signal("destabilize", penalty, level)

func get_stabilize_time():
	match stabilize_checks.count(StabilizeState.STABILIZED):
		2: return regular_stabilize_time
		1: return warning_stabilize_time
		0: return critical_stabilize_time
		_: return regular_stabilize_time

func get_current_level():
	return level

func get_current_penalty():
	return penalty

func get_time():
	return time

func get_stabilize_check_state(index: int):
	if stabilize_checks.size() != 0 && stabilize_checks.size() > index:
		return stabilize_checks[index]
	
	return StabilizeState.NEUTRAL
	


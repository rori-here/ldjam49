extends Camera2D

onready var shake_timer: Timer = $ShakeTimer

export var amplitude := 6.0
export var duration = 0.8 setget set_duration
export(float, EASE) var DAMP_EASING := 1.0
export var shake := false setget set_shake
	
export (Resource) var reactor_resource
onready var reactor: Reactor = reactor_resource

func _ready():
	randomize()
	set_process(false)
	self.duration = duration
	connect_to_timer()
	connect_to_reactor()

func _process(delta: float):
	var damping := ease(shake_timer.time_left / shake_timer.wait_time, DAMP_EASING)
	offset = Vector2(
		rand_range(amplitude, -amplitude) * damping,
		rand_range(amplitude, -amplitude) * damping)

func set_duration(value: int):
	duration = value
	shake_timer.wait_time = duration
	
func set_shake(value: bool):
	shake = value
	set_process(shake)
	offset = Vector2.ZERO
	if shake:
		shake_timer.start()

func _on_shake_timer_timeout():
	self.shake = false

func _on_camera_shake():
	self.shake = true

func connect_to_timer():
	shake_timer.connect("timeout", self, "_on_shake_timer_timeout")

func _on_reactor_heat(_heat, _level):
	_on_camera_shake()
	
func _on_reactor_meltdown(_level):
	_on_camera_shake()

func connect_to_reactor():
	reactor.connect("heated", self, "_on_reactor_heat")
	reactor.connect("meltdown", self, "_on_reactor_meltdown")
	

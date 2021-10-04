extends Camera2D

onready var shake_timer: Timer = $ShakeTimer

export var amplitude := 6.0
export var initial_duration = 0.8 
export(float, EASE) var DAMP_EASING := 1.0
export var shake := false setget set_shake

var duration = initial_duration setget set_duration
	
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
	set_duration(initial_duration)

func _on_camera_shake():
	self.shake = true

func connect_to_timer():
	shake_timer.connect("timeout", self, "_on_shake_timer_timeout")

func _on_destabilize(_heat, _level):
	_on_camera_shake()
	
func _on_destabilized(_level):
	set_duration(initial_duration * 4)
	_on_camera_shake()

func connect_to_reactor():
	reactor.connect("destabilize", self, "_on_destabilize")
	reactor.connect("destabilized", self, "_on_destabilized")

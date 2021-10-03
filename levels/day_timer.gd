extends Timer
class_name DayTimer

export (Resource) var day_resource
onready var day: Day = day_resource

func _ready():
	self.connect("timeout", self, "_on_timeout")
	
func _on_timeout():
	day.decrease_time(self.wait_time)

extends CenterContainer

export (Resource) var day_resource
onready var day: Day = day_resource

onready var day_label = $Panel/DayLabel
onready var day_label_initial_text = day_label.text

func _ready():
	set_text(day.get_time())
	day.connect("day_changed", self, "_on_day_changed")
	
func _on_day_changed(time: int):
	set_text(time)
	
func set_text(time: int):
	var mm = round(time / 60)
	var ss = time % 60
	
	day_label.text = "%02d:%02d" % [mm,ss]

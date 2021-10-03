extends CenterContainer

export (Resource) var day_resource
onready var day: Day = day_resource

onready var day_label = $DayLabel
onready var day_label_initial_text = $DayLabel.text

func _ready():
	set_text(day.get_time())
	day.connect("day_changed", self, "_on_day_changed")
	
func _on_day_changed(time: int):
	set_text(time)
	
func set_text(time: int):
	var mm = round(time / 60)
	var ss = time % 60
	
	if (ss == 0):
		day_label.text = day_label_initial_text.format({
			"mm": "0" + str(mm),
			"ss": "00",
		})
	else:
		day_label.text = day_label_initial_text.format({
			"mm": "0" + str(mm),
			"ss": ss,
		})

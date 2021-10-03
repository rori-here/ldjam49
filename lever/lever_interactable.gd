extends Interactable
class_name LeverInteractable

signal lever_pull(perfect)

onready var qte_timer_node: Timer = $Timer

export(float, 0.0, 2.0) var qte_interval_size = 0.3

var qte_time: float = 0.0
var qte_interval = [0.0, qte_interval_size]

func _ready():
	qte_timer_node.connect("timeout", self, "_on_qta_tick")
	set_qte_time()
	display_qte()

	interactable(false)

func interact():
	start_qte()

func start_qte():
	qte_interval = create_new_qte()
	qte_timer_node.start()

func _on_qta_tick():
	set_qte_time()
	display_qte()

func create_new_qte():
	var stepped_interval_size = stepify(qte_interval_size, 0.1)
	var random_number = rand_range(0, 1 - stepped_interval_size)
	var interval_start = stepify(random_number, 0.1)
	var interval_end = interval_start + qte_interval_size
	return [interval_start, interval_end]

func set_qte_time():
	if int(qte_time) == 2:
		qte_time = 0

	qte_time += qte_timer_node.wait_time

func display_qte():
	$SkillCheck.text = str(qte_time)

func _process(_delta):
	if (qte_timer_node && !qte_timer_node.is_stopped() && InputHelper.is_interact_just_pressed()):
		if (qte_time >= qte_interval[0] && qte_time <= qte_interval[1]):
			emit_signal("lever_pull", true)
			emit_signal("close_interaction")
		else:
			emit_signal("lever_pull", true)
			emit_signal("close_interaction")

func interactable(status):
	if status:
		$Interactable.show()
	else:
		$Interactable.hide()

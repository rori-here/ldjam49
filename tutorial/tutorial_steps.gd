extends Control

onready var step1 = $Tutorial/step1
onready var step2 = $Tutorial/step2
onready var step3 = $Tutorial/step3

var steps = []
var active_step = 0

func _ready():
	steps = [step1, step2, step3]
	show_active_step()

func show_active_step():
	for step in steps:
		step.hide()
	steps[active_step].show()

func _input(event):
	if InputHelper.is_ui_accept_just_pressed():
		if active_step == steps.size() - 1:
			get_tree().change_scene("res://World.tscn")
		else:
			active_step += 1
			show_active_step()

extends Node
class_name SoundManager

export (Resource) var reactor_resource
onready var reactor: Reactor = reactor_resource
onready var meltdown_audio_player = $MeltdownAudioPlayer
onready var sequence_success_audio_player = $SequenceSuccessAudioPlayer
onready var sequence_fail_audio_player = $SequenceFailAudioPlayer
onready var timer = $Timer

var audioPlayer 

func _ready():
	reactor.connect("stabilized", self, "_on_stabilized")
	reactor.connect("destabilized", self, "_on_destabilized")
	reactor.connect("stabilize", self, "_on_stabilize")
	reactor.connect("destabilize", self, "_on_destabilize")

func _on_stabilized():
	audioPlayer = sequence_success_audio_player
	
	timer.wait_time = 1
	timer.start()

func _on_stabilize(cool: int, level: int):
	audioPlayer = sequence_success_audio_player
	
	timer.wait_time = 1
	timer.start()

func _on_destabilize(penalty: int, level: int):
	audioPlayer = sequence_fail_audio_player

	timer.wait_time = 1
	timer.start()

func _on_destabilized():
	audioPlayer = meltdown_audio_player

	timer.wait_time = 1.3
	timer.start()

func _on_Timer_timeout():
	audioPlayer.play()
	

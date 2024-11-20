class_name HpLossText extends Label3D

var num : int = 10

@onready var timer : Timer = $Timer

func change_num(loss):
	num = loss
	text = "-"+str(num)
	visible = true
	timer.start()

func _on_timer_timeout():
	visible = false
	timer.stop()

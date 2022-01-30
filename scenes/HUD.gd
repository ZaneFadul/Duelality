extends CanvasLayer


func show_message(text):
	$Message.text = str(text)
	$Message.show()
	$MessageTimer.start()

func _ready():
	emit_signal('countdown_start')
	for i in range (3,0,-1):
		show_message(i)
		yield($MessageTimer,'timeout')
	show_message('DUEL')
	yield($MessageTimer,'timeout')
	emit_signal('countdown_end')
	$Message.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

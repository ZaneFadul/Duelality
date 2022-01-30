extends CanvasLayer

signal countdown_start
signal countdown_end

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

#connect('request_clone', get_node('/root/SnapshotManager'), '_on_clone_requested')

extends CanvasLayer

signal countdown_start
signal countdown_end

func update_round(new_round):
	$Round.text = str(new_round)
	$Round.show()

func show_message(text):
	$Message.text = str(text)
	$Message.show()
	$MessageTimer.start()

func _ready():
	get_node('/root/SnapshotManager').connect('new_round',self , 'on_round_start')
	
func on_round_start():
	update_round(get_node('/root/SnapshotManager').round_num)
	emit_signal('countdown_start')
	for i in range (3,0,-1):
		show_message(i)
		yield($MessageTimer,'timeout')
	show_message('DUEL')
	yield($MessageTimer,'timeout')
	$Message.hide()
	emit_signal('countdown_end')
	

#connect('request_clone', get_node('/root/SnapshotManager'), '_on_clone_requested')


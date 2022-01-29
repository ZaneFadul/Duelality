extends Node

var round_num
var MAX_ROUNDS = 3

signal request_clone(mainscene, player_scene, snapshot_payload)

func _ready():
	connect('request_clone', get_node('/root/SnapshotManager'), '_on_clone_requested')
	round_num = 1

func goto_next_round(mainscene, player_scene, snapshot_payload):
	print("round over...")
	if round_num == MAX_ROUNDS:
		print('winner')
	else:
		round_num += 1
		
		emit_signal('request_clone', mainscene, player_scene, snapshot_payload)
		
	

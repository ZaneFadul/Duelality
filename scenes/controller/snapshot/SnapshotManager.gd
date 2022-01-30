extends Node
var round_snapshots = {}
var round_num = 0


signal new_round()

func get_round_num(): 
	return round_num

func incr_round_num():
	round_num += 1
	emit_signal('new_round')

func _on_clone_requested(player_file, player_pos, snapshot_payload, mainscene):
	var new_player = load(player_file).instance()
	new_player.position = player_pos
	new_player.get_node('Sprite').modulate.a = .5
	
	var controllerPlayer = new_player.get_node("ControllerPlayer")
	controllerPlayer.upload_payload(snapshot_payload)
	mainscene.add_clone(new_player)

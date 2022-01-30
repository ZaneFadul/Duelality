extends Node

func _on_clone_requested(player_file, player_pos, snapshot_payload, mainscene):
	var new_player = load(player_file).instance()
	new_player.position = player_pos
	var controllerPlayer = new_player.get_node("ControllerPlayer")
	controllerPlayer.upload_payload(snapshot_payload)
	mainscene.add_clone(new_player)

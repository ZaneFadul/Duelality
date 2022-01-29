extends Node

func _on_clone_requested(mainscene, player_file, snapshot_payload):
	var new_player = load(player_file).instance()
	var controllerPlayer = new_player.get_node("ControllerPlayer")
	controllerPlayer.upload_payload(snapshot_payload)
	controllerPlayer.calibrate_snapshot()
	mainscene.add_child(new_player)

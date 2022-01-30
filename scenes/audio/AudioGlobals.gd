extends Node

var game_started = false

func get_game_started():
	return game_started
	
func _on_game_started():
	game_started = true

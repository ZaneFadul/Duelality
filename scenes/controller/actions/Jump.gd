extends Node

var action_pressed_by = {}

func function(params):
	
	var player = params["player"]
	if not action_pressed_by.has(player):
		action_pressed_by[player] = false
		
	if not action_pressed_by[player]:
		player._jump_pressed = true
		action_pressed_by[player] = true
	else:
		player._jump_pressed = false

func cleanup(params):
	var player = params["player"]
	player._jump_pressed = false
	action_pressed_by[player] = false

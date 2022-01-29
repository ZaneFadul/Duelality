extends Node

func function(params):
	var player = params['player']
	player._attack_pressed = true
	
func cleanup(params):
	var player = params['player']
	player._attack_pressed = false

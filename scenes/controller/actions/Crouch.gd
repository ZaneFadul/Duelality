extends Node

func function(params):
	var player = params['player']
	player._crouch_pressed = true

func cleanup(params):
	var player = params['player']
	player._crouch_pressed = false

extends Node

func function(params):
	var player = params['player']
	player._crouch_pressed = true
	player.set_collision_mask_bit(1, false)

func cleanup(params):
	var player = params['player']
	player._crouch_pressed = false
	player.set_collision_mask_bit(1, true)

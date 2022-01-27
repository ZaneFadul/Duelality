extends Node

func function(params):
	var player = params["player"]
	if player._velocity.x > -player.top_speed:
		player.speed = player.update_speed(player.speed, params["delta"], 'left')
		player._velocity.x -= player.speed
			
	#Slowdown while over top_speed
	else:
		player._velocity.x = lerp(player._velocity.x, -player.top_speed, .3)
	player.move_and_slide(player._velocity, player.UP_DIRECTION)

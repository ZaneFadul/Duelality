extends Node

func function(params):
	
	var player = params["player"]
	
	player._just_jumped = true
	player.is_double_jumping = player.is_falling
	player.is_jump_cancelled = player._velocity.y < 0.0


	
	#if is_jumping:
	#	_jumps_made += 1
	#	_velocity.y = -jump_strength
	#	_velocity.x *= .6
	#elif is_double_jumping:
	#	_jumps_made += 1
	#	_velocity.x *= .4
	#	if _jumps_made <= maximum_jumps:
	#		_velocity.y = -double_jump_strength
	#elif is_jump_cancelled:
	#	_velocity.y/=2
	#elif is_idling or is_running:
	#	_jumps_made = 0

extends Node

var round_num
var MAX_ROUNDS = 3

func _ready():
	round_num = 1

func goto_next_round():
	if round_num == MAX_ROUNDS:
		print('winner')
	else:
		round_num += 1
	

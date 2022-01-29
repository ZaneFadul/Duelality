extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print(self)
	print("hi im game ;D")
	$RoundManager.round_num = 1

func _on_player_killed(other_player):
	print("yo {player} is fucking dead".format({"player": other_player}))
	#check if that player was the main body or a clone
	if not other_player.is_clone():
		#if body, go to next round
		#if at last round, show win screen, go back to menu
		$RoundManager.goto_next_round()
	else:
		pass
		#Add a point to players score
	


extends Node2D

signal request_clone(mainscene, player_scene, snapshot_payload)

var player1inputconfig = {
	"LEFT": "MoveLeft",
	"RIGHT": "MoveRight",
	"UP" : "Jump",
	"DOWN": "Crouch",
	"SLASH": "Attack"
}

var player2inputconfig = {
	"A": "MoveLeft",
	"D": "MoveRight",
	"W": "Jump",
	"S": "Crouch",
	"E": "Attack"
}

var p1score = 0
var p2score = 0

var p1_starting_pos = Vector2(200, 0)
var p2_starting_pos = Vector2(500, 0)

var p1
var p2

var round_num
var MAX_ROUNDS = 3
var round_snapshots = {}

var main_scene = preload("res://scenes/Main.tscn")
var player_scene = preload("res://scenes/PlayerController.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	connect('request_clone', get_node('/root/SnapshotManager'), '_on_clone_requested')
	round_num = 1
	var main_instance = main_scene.instance()
	p1 = player_scene.instance()
	p2 = player_scene.instance()
	p1.action_map = player1inputconfig
	p2.action_map = player2inputconfig
	p1.position = p1_starting_pos
	p2.position = p2_starting_pos
	main_instance.add_players(p1, p2)
	add_child(main_instance)
	
func _process(_delta):
	pass
	
func _on_player_killed(player, killed_player, mainscene):
	print("yo {player} is fucking dead".format({"player": killed_player}))
	#check if that player was the main body or a clone
	if not killed_player.is_clone():
		#if body, go to next round
		#if at last round, show win screen, go back to menu
		if round_num != MAX_ROUNDS:
			if killed_player == p1:
				p2score += 1
			else:
				p1score += 1
		goto_next_round(player, killed_player, mainscene)
	else:
		if killed_player == p1:
			p2score += 1
		else:
			p1score += 1
		killed_player.queue_free()

func goto_next_round(player, killed_player, mainscene):
	print("round over...")
	p1.position = p1_starting_pos
	p2.position = p2_starting_pos
	p1.reset() #Start controller back at 0 seconds
	p2.reset() 
	if round_num == MAX_ROUNDS:
		handle_win()
	else:
		# Save snapshots in a snapshot per round
		round_snapshots[round_num] = {"p1":p1.get_snapshots(), "p2":p2.get_snapshots()}
	
		
		#Deleting all clones
		$Main.delete_clones()
		
		#Recreate all clones
		for i in round_num:
			emit_signal('request_clone', p1.filename, p1_starting_pos, round_snapshots[round_num]["p1"], $Main)
			emit_signal('request_clone', p2.filename, p2_starting_pos, round_snapshots[round_num]["p2"], $Main)
		round_num += 1

func handle_win():
	print('winner')

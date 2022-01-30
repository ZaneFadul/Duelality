extends Node

signal sending_payload(snapshots)

# Inputs object and current user inputs
var Inputs
var current_inputs = []

# Current action functions active
var current_actions = []

# List of completed action functions, plus their durations, player object, start time
var snapshots = []

# Action dictionary mapping the name of action to function ref object
var actions = {}

var start_time

var action_map

func _ready():
	action_map = get_parent().action_map
	Inputs = get_node("/root/Inputs")
	start_time = OS.get_ticks_msec()
	actions = Inputs.generate_key_action_pairs(action_map)
	
func _input(event):
	update_inputs(event)

func _physics_process(delta):
	update_inputs()
	for input in current_inputs:
		if input in actions:
			actions[input]["main"].call_func({"player":get_parent(), "delta": delta})
			
			var current_action_funcs = []
			for current_action in current_actions:
				current_action_funcs.append(current_action.keys()[0])
			if not actions[input] in current_action_funcs:
				start_action_timer(actions[input], {"start": OS.get_ticks_msec() - start_time})
		else:
			if input in action_map.keys():
				print(input + " does not have an action mapped to it. Fix that please : )")

func update_inputs(event=null):
	if event:
		for input in Inputs.input_list:
			if event.is_action_pressed(input): 
				current_inputs.append(input)
			if event.is_action_released(input):
				while input in current_inputs:
					current_inputs.remove(input)
					if not input in actions: return
					run_cleanup(actions[input])
					end_action_and_add_snapshot(actions[input])
	else:
		for input in Inputs.input_list:
			if Input.is_action_pressed(input) and not input in current_inputs:
				current_inputs.append(input)
				
func start_action_timer(actionfunc, delta):
	var new_action = {actionfunc: delta}
	for curr in current_actions:
		if curr.hash() == new_action.hash():
			return
	current_actions.append(new_action)
		
func end_action_and_add_snapshot(actionfunc):
	for curr in current_actions:
		if curr.keys()[0] == actionfunc:
			#add new snapshot
			var start = curr[actionfunc]["start"]
			var duration = OS.get_ticks_msec() - start_time - start
			var snapshot = {actionfunc: {
				"player": get_parent(),
				"start": curr[actionfunc]["start"],
				"duration": duration
			}}
			snapshots.append(snapshot)
			
			#erase
			current_actions.erase(curr)

func run_cleanup(action_obj):
	action_obj["cleanup"].call_func({"player":get_parent()})
	
func get_snapshots():
	 # TODO: Fix it so all actions that are not released are still added,
	# seems like not all held actions are being added

	for action in current_actions:
		end_action_and_add_snapshot(action.keys()[0])
	var to_return = snapshots
	snapshots = []
	return to_return
	
func send_snapshot_payload():
	emit_signal('sending_payload', snapshots)

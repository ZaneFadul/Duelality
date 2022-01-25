extends Node

var Inputs
var current_inputs = []

var actions = {}
export(Dictionary) var action_map

func _ready():
	Inputs = get_node("/root/Inputs")
	print(Inputs)
	actions = Inputs.generate_key_action_pairs(action_map)
	
func _input(event):
	for input in Inputs.input_list:
		if event.is_action_pressed(input):
			current_inputs.append(input)
		if event.is_action_released(input):
			while input in current_inputs:
				current_inputs.remove(input)

func _process(_delta):
	for input in current_inputs:
		if input in actions:
			actions[input].call_func()
		else:
			print(input + " does not have an action mapped to it. Fix that please : )")


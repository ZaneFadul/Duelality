extends Node2D

var MY_NAME = "Magic Cassette (SFX)"

var audio_logic_tree_scene
var song_controller_scene
var audio_manager_config_scene
var handle_error = funcref(self, '_on_error')
var output_message = funcref(self, '_on_output_message')

func _ready():
	print("%s is starting!" % MY_NAME)
	var base_path = get_script().resource_path
	var trimmed_path = base_path.substr(0, len(base_path)-16)
	var audio_manager_config_scene = load(trimmed_path + 'audio_manager_config.tscn')
	var config = audio_manager_config_scene.instance()
	config.handle_error = handle_error
	config.output_message = output_message
	add_child(config)

func _on_configured():
	var config = $audio_manager_config
	var base_path = get_script().resource_path
	var trimmed_path = base_path.substr(0, len(base_path)-16)
	audio_logic_tree_scene = load(trimmed_path + 'audio_logic_tree_handler.tscn')
	song_controller_scene = load(trimmed_path + 'song_controller.tscn')
	var audio_logic_tree_handler = audio_logic_tree_scene.instance()
	var song_controller = song_controller_scene.instance()
	audio_logic_tree_handler.set_state_directory(config.state_directory)
	audio_logic_tree_handler.set_audio_actions(config.audio_actions)
	audio_logic_tree_handler.set_trees(config.trees)
	audio_logic_tree_handler.handle_error = handle_error
	audio_logic_tree_handler.output_message = output_message
	song_controller.set_tracks(config.tracks)
	add_child(audio_logic_tree_handler)
	add_child(song_controller)
	
func handle_actions(actionArray):
	var audio_actions = $audio_logic_tree_handler.get_audio_actions()
	for action in actionArray:
		print('handle_actions ', action)
		var action_to_perform = null
		if typeof(action) == TYPE_DICTIONARY: action_to_perform = action
		elif audio_actions.has(action): action_to_perform = audio_actions[action]
		$song_controller.handle_action(action_to_perform)
		
func _on_perform_audio_action(action):
	$song_controller.handle_action(action)
	
func _on_state_changed(action):
	print(action)
	$song_controller.handle_action(action)

func _on_error(err_message):
	print('%s encountered an error: %s' % [MY_NAME, err_message])
	$song_controller.clear()
	set_process(false)

func _on_output_message(message):
	print('%s: %s' % [MY_NAME, message])

extends Node

var input_list = [
	"LEFT",
	"RIGHT",
	"UP",
	"DOWN"
]

var action_names = get_dir_contents("res://scenes/controller/actions/")
var actions = build_actions()

func build_actions():
	var to_return = {}
	for action_name in action_names:
		var base_path = get_script().resource_path
		var trimmed_path = base_path.substr(0, len(base_path)-9)
		var action_scene = load(trimmed_path + "actions/" + action_name + '.tscn')
		var scene = action_scene.instance()
		add_child(scene)
		to_return[action_name] = funcref(scene, "function")
	return to_return
	
func generate_key_action_pairs(dict):
	var to_return = {}
	for key in dict:
		to_return[key] = actions[ dict[key] ]
	return to_return
	
# Solution to get all action names in the subdir actions
# Courtesy of https://godotengine.org/qa/5175/how-to-get-all-the-files-inside-a-folder
func get_dir_contents(rootPath: String) -> Array:
	var files = []
	var directories = []
	var dir = Directory.new()

	if dir.open(rootPath) == OK:
		dir.list_dir_begin(true, false)
		_add_dir_contents(dir, files, directories, rootPath.length())
	else:
		push_error("An error occurred when trying to access the path.")

	return files

func _add_dir_contents(dir: Directory, files: Array, directories: Array, dir_string_len: int):
	var file_name = dir.get_next()

	while (file_name != ""):
		var path = dir.get_current_dir() + "/" + file_name

		if dir.current_is_dir():
			var subDir = Directory.new()
			subDir.open(path)
			subDir.list_dir_begin(true, false)
			directories.append(path)
			_add_dir_contents(subDir, files, directories, path.length())
		else:
			var tscn_extension_len = 5 #.tscn			
			var is_tscn = path.substr(path.length()-tscn_extension_len, tscn_extension_len) == ".tscn"
			if is_tscn:
				files.append(path.substr(dir_string_len, path.length()-dir_string_len-tscn_extension_len))

		file_name = dir.get_next()

	dir.list_dir_end()

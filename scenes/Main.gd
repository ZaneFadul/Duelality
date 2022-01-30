extends Node

var clones = []
		
func _ready():
	print("greetings")
	
func add_clone(clone_instance):
	add_child(clone_instance)
	
func reset():
	print(get_parent())
	get_tree().change_scene_to(load(get_parent().filename))
	
func add_players(p1, p2):
	add_child(p1)
	add_child(p2)

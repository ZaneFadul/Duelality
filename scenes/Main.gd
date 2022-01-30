extends Node

var clones = []
		
func add_clone(clone_instance):
	clones.append(clone_instance)
	add_child(clone_instance)
	
func delete_clones():
	print("deleting clones")
	
	# Have no idea why this isn't actually deleting the clones, but...
	for i in clones:
		remove_child(i)
		i.queue_free()
		
	
func add_players(p1, p2):
	add_child(p1)
	add_child(p2)

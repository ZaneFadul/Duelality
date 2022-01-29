extends Node

enum {MENU, GAME}
var displays = {
	MENU: 'res://scenes/managers/Menu.tscn',
	GAME: 'res://scenes/managers/Game.tscn'
}
var state = GAME

func _ready():
	update()
			
func show(_state):
	for n in get_children():
		n.queue_free()
	var scene = load(displays[_state])
	add_child( scene.instance() )

func update():
	match state:
		MENU:
			#show menu
			show(MENU)
		
		GAME:
			#show game
			show(GAME)

func get_states():
	return [MENU, GAME]
	
func _on_state_changed(new_state):
	state = new_state
	update()

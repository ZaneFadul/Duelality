extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Start_pressed():
	get_tree().change_scene("res://scenes/managers/Game.tscn")


func _on_Quit_pressed():
	get_tree().quit()
extends CanvasLayer


onready var anim_player = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	var map = get_parent().get_node("Map")
	map.connect("impact", self, "start_impact")
	


func start_impact():
	anim_player.current_animation = "shockwave"
	anim_player.play()
	print("shockwave!")

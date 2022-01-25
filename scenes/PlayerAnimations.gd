extends AnimationTree

var playback : AnimationNodeStateMachinePlayback
onready var root = get_node("../")

func _ready():
	playback = get("parameters/playback")
	playback.start('Idle')
	active = true
	
func _process(delta):
	print(root.get('animation_state'))
	var character_animation_state = root.get('animation_state')
	
	match character_animation_state:
		'IDLE':
			playback.travel('Idle')
		'RUN':
			playback.travel('Run')
		'ATTACK':
			playback.travel('Attack')
		'RISING':
			playback.travel('Rising')
		'FLOATING':
			playback.travel('Floating')
		'FALLING':
			playback.travel('Falling')
		'CROUCH':
			playback.travel('Crouch')

	

extends Area2D

var current_state = 'idle'


func _ready():
	set_physics_process(false)
	
func change_state(new_state):
	current_state = new_state
	
	match current_state:
		'idle':
			set_physics_process(false)
			$AnimatedSprite.play('idle')
		'active':
			set_physics_process(true)
			$AnimatedSprite.play('active')

func _physics_process(delta):
	print(current_state)
	var hit_bodies = get_overlapping_bodies()
	if not hit_bodies:
		pass
	
	for body in hit_bodies:
		pass
		#Check damage/kill
	
	change_state('idle')
	print(current_state)

	
	
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

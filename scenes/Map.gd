extends Node2D


var timer_on = false
var timer_stopped = false
var timer = Timer.new()
var range_top = 30
onready var anim_player = get_node("AnimationPlayer")

export var animation_state = 'idle'


signal shake
signal flash
signal impact

# Called when the node enters the scene tree for the first time.
func _ready(): 
	var game = get_parent().get_parent()
	game.connect('round_reset',self, "round_restart")
	var hud = get_parent().get_node("HUD")
	hud.connect("countdown_start", self, "start_round")
	timer.connect("timeout", self, "_on_timer_timeout")
	add_child(timer)
	anim_player.current_animation = "towers" # to pause (during round countdowns) add keyframe to jump to to snapshot manager


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var range_tuple = Vector2(.2,range_top)
	randomize()
	var t = rand_range(range_tuple.x,range_tuple.y)
	
	if timer_on == false and not timer_stopped:
		timer.set_wait_time(t)
		timer.start()
		timer_on = true
	if(range_top>3):
		range_top -= delta*.3 #as time goes on elevator shakes more
	

func start_round():
	anim_player.play()
	emit_signal("shake", .8, .1, 20)
	print("SHAKE-START")
	
	
	
func round_restart():
	print("RESTART")
	anim_player.stop()
	emit_signal("impact")
	emit_signal("flash", 0.15, 0.4, "white")

func _on_timer_timeout():
	timer_on = false
	emit_signal("shake", .4, .05, 3)
	#print("SHAKE")
	if anim_player.current_animation == "fall":
		emit_signal("flash", 0.15, 0.25, "red")
	


func _on_AnimationPlayer_animation_started(anim_name):
	
	print("SHAKE-START")

#FALLING DROP CONSTANT SHAKE
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "towers":
		range_top = .5
		emit_signal("shake", .4, .1, 20)
		emit_signal("flash", 0.25, 0.7, "red")
		print("FALLING SHAKING")
		anim_player.current_animation = "fall"
	else:
		print("CRASH LANDING")
		timer_stopped = true
		emit_signal("shake", .4, .1, 40)
		timer.stop()

extends Camera2D

onready var timer_shake_length = $timer_shake_length
onready var timer_wait_time = $timer_wait_times
onready var tween_shake = $Tween
onready var flash_image = $Sprite
onready var flash_image_white = $Sprite2

var reset_speed = 0
var strength = 0
var doing_shake = false



# Called when the node enters the scene tree for the first time.
func _ready():
	var map = get_parent().get_node("Map")
	#shake random intervals
	map.connect("shake", self, "start_shake")
	#FLASH
	map.connect("flash", self, "start_flash")
	timer_wait_time.connect("timeout", self, "timeout_wait_times")
	timer_shake_length.connect("timeout", self, "timeout_shake_length")

#stop shaking and reset camera
func timeout_shake_length():
	doing_shake = false
	reset_camera()
#shakes
func timeout_wait_times():
	if(doing_shake):
		tween_shake.interpolate_property(self, "offset", offset, Vector2(rand_range(-strength, strength), rand_range(-strength,strength)), reset_speed, Tween.TRANS_SINE, Tween.EASE_OUT)
		tween_shake.start()
#once finished shaking, tween back to original
func reset_camera():
	tween_shake.interpolate_property(self, "offset", offset, Vector2(0,0), reset_speed, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween_shake.start()
	
#start the shake
func start_shake(time_of_shake, speed_of_shake, strength_of_shake):
	doing_shake = true
	strength = strength_of_shake
	reset_speed = speed_of_shake
	timer_shake_length.start(time_of_shake)
	timer_wait_time.start(speed_of_shake)
	
#flashbang!
func start_flash(speed, strength, color):
	if(color == "red"):
		tween_shake.interpolate_property(flash_image, "modulate:a", 0, strength, speed, Tween.TRANS_SINE, Tween.EASE_OUT)
		tween_shake.start()
		
		yield(get_tree().create_timer(speed), "timeout")
		tween_shake.interpolate_property(flash_image,"modulate:a", strength, 0, speed, Tween.TRANS_SINE, Tween.EASE_OUT)
		tween_shake.start()
	else:
		tween_shake.interpolate_property(flash_image_white, "modulate:a", 0, strength, speed, Tween.TRANS_SINE, Tween.EASE_OUT)
		tween_shake.start()
		
		yield(get_tree().create_timer(speed), "timeout")
		tween_shake.interpolate_property(flash_image_white,"modulate:a", strength, 0, speed, Tween.TRANS_SINE, Tween.EASE_OUT)
		tween_shake.start()
	

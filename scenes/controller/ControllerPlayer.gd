extends Node

var is_clone = true
var snapshot_payload
var can_playback = false
var start_time

func _ready():
		get_parent().get_node("Controller").connect("sending_payload", self, "_on_payload_received")
		
func _process(delta):
	if not is_clone:
		queue_free()
	if can_playback:
		playback(delta)

func playback(delta):
	for snapshot in snapshot_payload:
		var actionfunc = snapshot.keys()[0]
		var curr_time = OS.get_ticks_msec() - start_time
		var time_to_end = snapshot[actionfunc]["start"] + snapshot[actionfunc]["duration"]
		if curr_time >= snapshot[actionfunc]["start"] and curr_time < time_to_end:
			actionfunc.call_func({"player": snapshot[actionfunc]["player"], "delta": delta})
		
func _on_payload_received(payload):
	snapshot_payload = payload
	start_time = OS.get_ticks_msec()
	can_playback = true

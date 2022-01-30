extends Node

var is_clone = false
var snapshot_payload
var can_playback = false
var start_time

func _ready():
		get_parent().get_node("Controller").connect("sending_payload", self, "_on_payload_received")
		
func _process(delta):
	if not is_clone:
		return
	if can_playback:
		playback(delta)

func playback(delta):
	for snapshot in snapshot_payload:
		var actionfunc = snapshot.keys()[0]
		var curr_time = OS.get_ticks_msec() - start_time
		var time_to_end = snapshot[actionfunc]["start"] + snapshot[actionfunc]["duration"]
		if curr_time >= snapshot[actionfunc]["start"] and curr_time < time_to_end:
			actionfunc["main"].call_func({"player": snapshot[actionfunc]["player"], "delta": delta})
		elif curr_time > time_to_end:
			if not snapshot[actionfunc]["cleaned"]:
				actionfunc["cleanup"].call_func({"player": snapshot[actionfunc]["player"], "delta": delta})
				snapshot[actionfunc]["cleaned"] = true
		
func _on_payload_received(payload):
	snapshot_payload = payload
	start_time = OS.get_ticks_msec()
	can_playback = true

func upload_payload(payload):
	is_clone = true
	snapshot_payload = payload
	start_time = OS.get_ticks_msec()
	can_playback = true
	calibrate_snapshot()
	
func calibrate_snapshot():
	for snapshot in snapshot_payload:
		var actionfunc = snapshot.keys()[0]
		#snapshot[actionfunc]["start"] = start_time - snapshot[actionfunc]["start"]
		snapshot[actionfunc]["player"] = get_parent()
		snapshot[actionfunc]["cleaned"] = false

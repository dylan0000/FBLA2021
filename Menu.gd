extends Popup

var paused = false

func _unhandled_input(event):
	if Input.is_action_just_pressed("pause"):
		paused = !paused
		
		if paused == true:
			get_parent().get_node("Player").set_process_input(false)
			popup()
			get_tree().paused = true
			$Time.text = "Time: " + str(Global.time) + " seconds"
		elif paused == false:
			get_parent().get_node("Player").set_process_input(true)
			hide()
			get_tree().paused = false

# ugly pause menu

func _on_Button_pressed(): # resets progress, but not record time for this run
	get_tree().paused = false
	get_tree().change_scene("res://Start.tscn")
	Global.time = 0
	Global.buttons = 0
	Global.level = 1
	Global.score = 0

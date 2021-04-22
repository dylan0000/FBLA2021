extends Button



func _on_Button_pressed():
	get_tree().change_scene("res://World.tscn")
	Global.time = 0
	Global.buttons = 0
	Global.level = 1
	Global.score = 0

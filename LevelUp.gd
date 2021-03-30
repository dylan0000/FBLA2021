extends Area2D


func _on_LevelUp_body_entered(body):
	if body.is_in_group("Player"):
		Global.score += 3
		Global.level += 1
		Global.buttons = -1
		#Global.emptyarray += 
#		print(get_parent().get_node("Button").str2var("coords" + Global.level))
		Global.time = OS.get_ticks_msec()/1000
		print(Global.time)
		get_tree().change_scene("res://World" + str(Global.level) + ".tscn")
		

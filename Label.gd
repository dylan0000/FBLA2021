extends Label

func _ready():
	

	
	if Global.recordtime != null:
		if Global.time < Global.recordtime:
			Global.recordtime = Global.time
	else:
		Global.recordtime = Global.time
		
	if Global.recordscore != null:
		if Global.score > Global.recordscore:
			Global.recordscore = Global.score	
	else:
		Global.recordscore = Global.score
		
	text = "Finished! time: "  + str(Global.time) + " Score: " + str(Global.score)
	
	
	get_parent().get_node("Record").text = "Record Time (Current session) was: " + str(Global.recordtime) + ", and record score (Current session) was: " + str(Global.recordscore)
	
# set and replace records checking for global and current score

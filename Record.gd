extends Label


func _ready():
	if Global.recordtime != null:
		text = str(Global.recordtime)
	else:
		text = "No record yet!"

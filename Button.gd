extends Area2D

export var canpress = true
onready var camera = get_parent().get_node("Camera2D")

var coords = { 1: [Vector2(160,8), Vector2(472,8), Vector2(736,8)],
			2: [Vector2(160,8),Vector2(472,8), Vector2(864, 8)],
			3: [Vector2(200,8),Vector2(592,8), Vector2(984,8)]}


func _on_Button_body_entered(body):
	if body.is_in_group("Player"):
		var g = get_parent().get_node("Safe")
		g.visible = true
		if self.canpress == true:
			if Global.buttons < int(self.name):
				Global.buttons += 1
			Global.score += 1
			print(Global.score)
			print(Global.buttons)
		camera.get_node("Label").text = "Score: " + str(Global.score)
		self.canpress = false
		camera.position = coords[Global.level][Global.buttons]
			

func _on_Button_body_exited(body):
	if body.is_in_group("Player"):
		var g = get_parent().get_node("Safe")
		g.visible = false
		var spawn = get_parent().get_node("Spawn")
		spawn.position = position


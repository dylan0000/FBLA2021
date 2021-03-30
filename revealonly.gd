extends Area2D


func _on_9_body_entered(body):
	if body.is_in_group("Player"):
		var g = get_parent().get_node("Safe")		
		g.visible = true

func _on_9_body_exited(body):
	var g = get_parent().get_node("Safe")
	g.visible = false
	var spawn = get_parent().get_node("Spawn")
	spawn.position = position

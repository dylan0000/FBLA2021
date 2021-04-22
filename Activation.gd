extends Area2D

var canmove = false

var speed = 0
var distance = Vector2()
var velocity = Vector2()

func _physics_process(delta):
	if canmove:
		var newpos = get_parent().get_node("Stop").global_position
		distance = newpos - get_parent().global_position
		velocity = distance * speed * delta

		get_parent().global_position += velocity

func _on_Plate_body_entered(body):
	if body.is_in_group("Player"):
		get_parent().visible = true
		canmove = true
		speed = 2
		get_parent().get_node("ClearTimer").start()
		
# sets off trap 


func _on_ClearTimer_timeout():
	get_parent().queue_free()

extends KinematicBody2D


enum {
	ACTIVE,
	IDLE
}

var state = IDLE


var tile_size = 16
var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}
			
func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2	
	
		
func _unhandled_input(event):
	for di in inputs.keys():
		if event.is_action_pressed(di):
			$WallChecker.cast_to = Vector2(inputs[di] * tile_size)
			yield(get_tree().create_timer(0.01), "timeout")
			move(di)
			if inputs[di] == Vector2.RIGHT:
				$AnimationPlayer.flip_h = false
			elif inputs[di] == Vector2.LEFT:
				$AnimationPlayer.flip_h = true
		else:
			state = IDLE
			
func move(di):
	if not $WallChecker.is_colliding():
		position += inputs[di] * tile_size
		print(di)
		state = ACTIVE
		get_parent().get_node("Label2").visible = false
	elif $WallChecker.is_colliding():
		if $WallChecker.get_collider().is_in_group("Danger"):
			position += inputs[di] * tile_size
			

func _process(delta):
	match state:
		ACTIVE:
			$AnimationPlayer.play("Running")
		IDLE:
			$AnimationPlayer.play("Idle")


func _on_Hitbox_body_entered(body):
	if body.is_in_group("Danger"):
		position = get_parent().get_node("Spawn").position
		Global.score -= 1
		if Global.score < 0:
			Global.buttons = 0
			Global.level = 1
			Global.score = 0
			get_tree().change_scene("res://World.tscn")

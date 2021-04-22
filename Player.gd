extends KinematicBody2D

#player code for movement

enum {
	ACTIVE,
	IDLE
}

var state = IDLE
var isdead = false

var tile_size = 16
var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}
			
func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2	

func _physics_process(delta):
	Global.time += delta
		
func _input(event):
	for di in inputs.keys():
		if event.is_action_pressed(di):
			$WalkSound.play()
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
	elif $WallChecker.is_colliding():
		if $WallChecker.get_collider().is_in_group("Danger"):
			position += inputs[di] * tile_size
			

func _process(delta):
	if isdead == false:
		match state:
			ACTIVE:
				$AnimationPlayer.play("Running")
			IDLE:
				$AnimationPlayer.play("Idle")


func _on_Hitbox_body_entered(body):
	if body.is_in_group("Danger"):
		isdead = true
		position = get_parent().get_node("Spawn").position
		get_parent().get_node("Player").set_process_input(false)
		$Deathbackground.visible = true
		$DeathSound.play()
		$AnimationPlayer.scale = Vector2(5,5)

		$AnimationPlayer.play("Death")
		yield($AnimationPlayer, "animation_finished")		
		die()
		
			
func die():
	$Deathbackground.visible = false
	$DeathSound.stop()
	$AnimationPlayer.scale = Vector2(1,1)
	get_parent().get_node("Player").set_process_input(true)
	isdead = false
	Global.score -= 1
	if Global.score < 0:
		get_parent().get_node("Camera2D/Label").text = "Score: " + str(Global.score)
		Global.buttons = 0
		Global.level = 1
		Global.score = 0
		get_tree().change_scene("res://World.tscn")

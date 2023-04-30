extends Node

var sm
# Called when the node enters the scene tree for the first time.
func enter():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func loop(delta):
	sm.body.velocity.y -= ProjectSettings.get_setting("physics/3d/default_gravity") * delta
	sm.body.move_and_slide()
	
	if sm.body.is_on_floor():
		exit_to_standing()



func exit_to_standing():
	sm.state = $"../Standing"
	pass
	
func exit_to_running():
	sm.state = $"../Running"
	pass
	
func exit_to_jumping():
	pass
	
func exit_to_climbing():
	sm.state = $"../Climbing"
	pass

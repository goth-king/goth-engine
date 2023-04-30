extends Node

var sm
# Called when the node enters the scene tree for the first time.
func enter():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func loop(delta):
	pass



func exit_to_standing():
	sm.state = $"../Standing"
	pass
	
func exit_to_running():
	sm.state = $"../Running"
	pass
	
func exit_to_jumping():
	sm.state = $"../Jumping"
	pass
	
func exit_to_climbing():
	pass

extends Node

var sm
# Called when the node enters the scene tree for the first time.
func enter():
	sm.animtree.set("parameters/RunBlend/blend_amount",0.0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func loop(delta):
	
	if not sm.body.is_on_floor():
		exit_to_jumping()
		
	if sm.body.movement.length() > 0:
		exit_to_running()




func exit_to_standing():
	pass
	
func exit_to_running():
	sm.state = $"../Running"
	pass
	
func exit_to_jumping():
	sm.state = $"../Jumping"
	pass
	
func exit_to_climbing():
	sm.state = $"../Climbing"
	pass
	

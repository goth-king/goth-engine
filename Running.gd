extends Node

var sm
# Called when the node enters the scene tree for the first time.
func enter():
	sm.animtree.set("parameters/RunBlend/blend_amount",1.0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func loop(delta):
	var speedmod = 1
#	if sm.animtree.current_animation == "Man/Run":
#		speedmod = 0.5


	if sm.body.movement.length() == 0:
		exit_to_standing()
		
	else:		
		sm.body.velocity.y -= sm.body.gravity
		sm.body.velocity.x = sm.body.speed * sm.body.movement.x * speedmod
		sm.body.velocity.z = sm.body.speed * sm.body.movement.z * speedmod
		sm.body.move_and_slide()
		sm.body.look_at(Vector3(sm.body.position.x + sm.body.movement.x, sm.body.position.y, sm.body.position.z + sm.body.movement.z))





func exit_to_standing():
	sm.state = $"../Standing"
	pass
	
func exit_to_running():
	pass
	
func exit_to_jumping():
	sm.state = $"../Jumping"
	pass
	
func exit_to_climbing():
	sm.state = $"../Climbing"
	pass

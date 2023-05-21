extends Action
class_name MeleeAttack


func enter_state():
	sm.animation_tree.set("parameters/ActionShot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

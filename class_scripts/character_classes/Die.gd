extends CharacterState
class_name Dying


func enter_state():

	if state_animation:
		sm.animation_tree.tree_root.get_node("Action").animation = state_animation
		sm.animation_tree.set("parameters/ActionShot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		duration = sm.animation_player.get_animation(state_animation).length
#		await get_tree().create_timer(duration).timeout
		var exit_timer = Timer.new()
		add_child(exit_timer)
		exit_timer.one_shot = true
		exit_timer.timeout.connect(die)
		exit_timer.start(duration-0.2)

func die():
	sm.character.queue_free()

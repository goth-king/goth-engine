extends CharacterState
class_name Reaction

@export var standing_state : CharacterState
@export var movement_state : CharacterState
@export var falling_state : CharacterState
@export var action_state : CharacterState


# Called when the node enters the scene tree for the first time.
func enter_state():
	if state_animation:
		sm.animation_tree.tree_root.get_node("Reaction").animation = state_animation
		sm.animation_tree.set("parameters/ReactionShot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		duration = sm.animation_player.get_animation(state_animation).length
#		await get_tree().create_timer(duration).timeout
		var timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.timeout.connect(change_state)
		timer.start(duration)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_step(delta):
	pass
	
	
func change_state():
	if not sm.character.is_on_floor():
		sm.change_state(falling_state)
		
	elif sm.input.action:
		sm.change_state(self)
		
	elif sm.input.movement.length() > 0:
		sm.change_state(movement_state)
			
	else:
		sm.change_state(standing_state)
	
func exit_state():
	sm.animation_tree.set("parameters/ReactionShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)

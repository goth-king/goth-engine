extends CharacterState
class_name Action

@export var standing_state : CharacterState
@export var movement_state : CharacterState
@export var falling_state : CharacterState
@export var reaction_state : CharacterState

@export var spawn_scene : PackedScene



# Called when the node enters the scene tree for the first time.
func enter_state():
	sm.character.turn(sm.input.movement)
	
	if state_animation:
		sm.animation_tree.tree_root.get_node("Action").animation = state_animation
		sm.animation_tree.set("parameters/ActionShot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		duration = sm.animation_player.get_animation(state_animation).length
		
		get_tree().create_timer(duration).timeout.connect(change_state)
		get_tree().create_timer(duration/2).timeout.connect(spawn_hitbox)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_step(delta):
	pass
	
func spawn_hitbox():
	sm.character.spawn(spawn_scene)
	
	
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
	sm.animation_tree.set("parameters/ActionShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)

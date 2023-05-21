extends CharacterState
class_name Running

@export var falling_state : CharacterState
@export var standing_state : CharacterState
@export var action_state : CharacterState

# Called when the node enters the scene tree for the first time.
func enter_state():
	
	sm.animation_tree.set("parameters/RunBlend/blend_amount",1.0)

## Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_step(delta):

	if sm.input.movement.length() == 0:
		sm.change_state(standing_state)
		
	elif not sm.character.is_on_floor():
		sm.character.jump()
		sm.change_state(falling_state)
		
	elif sm.input.action:
		sm.change_state(action_state)

	else:		
		sm.character.travel(sm.input.movement,1)

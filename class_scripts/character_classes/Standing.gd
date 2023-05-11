extends CharacterState
class_name Standing

@export var falling_state : CharacterState
@export var movement_state : CharacterState
@export var action_state : CharacterState

# Called when the node enters the scene tree for the first time.
func enter_state():
	
	print("CharacterState:Standing")
	sm.animation_tree.set("parameters/RunBlend/blend_amount",0.0)
	
	


func physics_step(delta):
	if not sm.character.is_on_floor():
		sm.change_state(falling_state)

	elif sm.input.movement.length() > 0:
		sm.change_state(movement_state)
		
	elif sm.input.action:
		print("attack!")
		sm.change_state(action_state)



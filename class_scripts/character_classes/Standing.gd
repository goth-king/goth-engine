extends CharacterState
class_name Standing

@export var falling_state : CharacterState
@export var movement_state : CharacterState
@export var action_state : CharacterState
@export var reaction_state : CharacterState
@export var death_state : CharacterState

# Called when the node enters the scene tree for the first time.
func enter_state():
	sm.character.connect("hit",to_hit_state)
	sm.character.connect("die",to_die_state)
	
	sm.animation_tree.set("parameters/RunBlend/blend_amount",0.0)
	
	
func physics_step(delta):
	if not sm.character.is_on_floor():
		sm.change_state(falling_state)

	elif sm.input.movement.length() > 0:
		sm.change_state(movement_state)
		
	elif sm.input.action:
		sm.change_state(action_state)
		
func to_hit_state():
	print("I am hit!")
	sm.change_state(reaction_state)
	
func to_die_state():
	print("I am dead!")
	sm.change_state(death_state)


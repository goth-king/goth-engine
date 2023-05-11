extends CharacterState
class_name Action

@export var standing_state : CharacterState
@export var movement_state : CharacterState
@export var falling_state : CharacterState

# Called when the node enters the scene tree for the first time.
func enter_state():
	print("CharacterState:Attacking")
	sm.animation_tree.set("parameters/AttackShot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	
	await get_tree().create_timer(0.75).timeout
	sm.character.turn(sm.input.movement)
	
	if not sm.character.is_on_floor():
		sm.change_state(falling_state)
	
	elif sm.input.action:
		sm.change_state(self)
	
	elif sm.input.movement.length() > 0:
		sm.change_state(movement_state)
		
	else:
		sm.change_state(standing_state)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_step(delta):
	pass

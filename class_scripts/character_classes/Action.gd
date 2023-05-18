extends CharacterState
class_name Action

@export var standing_state : CharacterState
@export var movement_state : CharacterState
@export var falling_state : CharacterState
@export var character_animation : String

# Called when the node enters the scene tree for the first time.
func enter_state():
	print("CharacterState:Attacking")
	
	sm.animation_tree.tree_root.get_node("Action").animation = character_animation
	sm.animation_tree.set("parameters/ActionShot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	
	sm.character.spawn("res://punch.tscn")
	
	await get_tree().create_timer(0.85).timeout
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
	
	
func exit_state():
	sm.animation_tree.set("parameters/ActionShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)

extends CharacterState
class_name Falling

@export var standing_state : CharacterState
@export var movement_state : CharacterState

# Called when the node enters the scene tree for the first time.
func enter_state():
	pass

## Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_step(delta):
	sm.character.velocity.y -= sm.character.gravity
	sm.character.move_and_slide()

	if sm.character.is_on_floor():
		if sm.input.movement.length() > 0:
			sm.change_state(movement_state)
		else:
			sm.change_state(standing_state)


extends CharacterState
class_name Falling

@export var standing_state : CharacterState
@export var movement_state : CharacterState

# Called when the node enters the scene tree for the first time.
func enter_state():
	print("sm ", sm)
	print("CharacterState:Falling")

## Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_step(delta):
	sm.character.velocity.y -= sm.character.gravity
	sm.character.move_and_slide()

	if sm.character.is_on_floor():
		sm.change_state(standing_state)


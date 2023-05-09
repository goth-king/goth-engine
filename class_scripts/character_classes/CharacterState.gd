@icon("res://icons/state.png")
extends Node
class_name CharacterState

@onready var sm : CharacterStateMachine = get_parent()
@onready var accept_action : bool

func change_state(state : CharacterState):
	sm.state = state


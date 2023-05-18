@icon("res://icons/state_machine.png")
extends Node
class_name CharacterStateMachine

	
@export var character : Character
@export var input : CharacterInput
@export var animation_tree : AnimationTree
@export var initial_state : CharacterState

@onready var state : CharacterState = initial_state

func _ready():
	state.sm = self
	state.enter_state()
	
func _physics_process(delta):
	state.physics_step(delta)
	pass

func change_state(_state):
	state.exit_state()
	state = _state
	state.sm = self
	state.enter_state()




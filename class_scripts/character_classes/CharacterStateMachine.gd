@icon("res://icons/state_machine.png")
extends Node
class_name CharacterStateMachine

@export var character_body : CharacterBody3D
@export var animation_tree : AnimationTree
@export var character_input : CharacterInput
@export var initial_state : CharacterState

@onready var state = initial_state:
	set(_state):
		_set_state(_state)





func _set_state(_state):
	print("state is ",_state)
	for i in get_children():
		i.queue_free()
	add_child(_state)
	connect_action(_state)
	
	
func connect_action(_state):
	if _state.accept_action:
		character_input.connect("action_pressed",_state.change_state)
	





@icon("res://icons/state_icon.png")
extends Node
class_name CharacterState

var sm : CharacterStateMachine

@export var state_animation : String

var duration

func _ready():
	pass
	
func enter_state():
	pass
	
func physics_step(delta):
	pass
	
func exit_state():
	pass

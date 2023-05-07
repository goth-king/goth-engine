extends CharacterBody3D
class_name Character

@export var base_speed = 3
@export var jump_height = 2
@export var sight_radius = 5.0
@export var state_machine : CharacterStateMachine


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var jump_speed = sqrt(2 * gravity * jump_height)

# Called when the node enters the scene tree for the first time.
func _ready():
		pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func states():
	pass

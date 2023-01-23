extends CharacterBody3D



### New Idea ###
### ARPGs need a very flexible input-action system to achieve smooth gameplay.
##		
#		Issue: The combination of fighting mechanics and player controls in ARPGs frewquently leads to frantic "button mashing" gameplay.
#			This occurs because the player is uncertain if the inputs are causing actions.
#				E.g. player may press "attack" while the "block" is still happening, amd the game doesnt respond to the attack input
#				The player will mash the "attack" button to try to get the attack to happen as soon as the block is done
#				When a sequence of buttons needs to be pressed to get the desired result, the player may make a series of mestakes, leading to giving up and mashing buttons
#			
##
#		Goal: avoid frantic gameplay, "button mashing"
#			The supply of player inputs should closely match the demand of character actions
#			The breadth of inputs (how many buttons or keys are required for gameplay) should match the number of actions available to the character
#				Reduce having to swap skills, browse menus, or require multi-step inputs
#			The timing of input should match the timing of actions
#				Does the player have a tendency to click "attack" more rapidly than the character can attack?
##
#		Approach:
#			Action queue with intuitive priority system based action overrides (e.g. use item overrides move, but attack overrides use item
#			Up to 2 (or 3?) actions will be held in a buffer and played sequentially based on input timing and priority overrides
#
#		Benefit:
#			Less fatiguing gameplay by reducing wasted inputs
#			More confidence in controls and a better feeling of quality (input causes the expected output (almost) every time)
#			



## Below is a character motion system using a state machine pattern. This will be replaced with a different system described above.

@export var speed : float = 5.0
@export var jump : float = 5.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") / ProjectSettings.get_setting("physics/common/physics_ticks_per_second")

enum STATE {IDLE, MOVING, FALLING}
var state = STATE.IDLE


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	
	var movement = get_movement_input()
	
	velocity.x = speed * movement.x
	velocity.z = speed * movement.z

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump

	match state:
		STATE.IDLE:
			state = state_idle()
		STATE.MOVING:
			state = state_moving()
		STATE.FALLING:
			state = state_falling()


func state_idle():

	if not is_on_floor():
		return STATE.FALLING
	elif velocity.length() != 0:
		return STATE.MOVING
	else:
		return STATE.IDLE
	
func state_moving():
	
	if not is_on_floor():
		return STATE.FALLING
	elif velocity.length() == 0:
		return STATE.IDLE
	else:
		move_and_slide()
		return STATE.MOVING

	
func state_falling():
	
	if not is_on_floor():
		velocity.y -= gravity
		move_and_slide()
		return STATE.FALLING
	else:
		return STATE.IDLE
	


func get_movement_input():
	var input : Vector3
	var orientation:Vector3
	var camera = get_viewport().get_camera_3d()
	
	input.x = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
	input.z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	orientation.x = camera.position.x - position.x
	orientation.z = camera.position.z - position.z
	
	input = (orientation * input.z) + (orientation.cross(Vector3.UP) * input.x)
	
	if input.length() > 1:
		input = input.normalized()
		
	return input

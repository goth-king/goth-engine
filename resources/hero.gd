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
#		Addendum:
#			Simultaneous actions (e.g. move & attack)
#			Actiosn influenced by other actions, and by states (attack while moving, and while also blinded)
#			



## Below is a character motion system using a state machine pattern. This will be replaced with a different system described above.

@export var speed : float = 5.0
@export var jump : float = 5.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") / ProjectSettings.get_setting("physics/common/physics_ticks_per_second")


enum STATE {IDLE, MOVING, FALLING}
var state = STATE.IDLE

@onready var animplayer : AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	var movement = get_movement_input()
	look_at(global_transform.origin + movement)
	
	var action = get_action_input()

	

	if not is_on_floor():
		state = STATE.FALLING	
		state_falling()
	elif movement.length() > 0:
		state = STATE.MOVING
		state_moving()
	else:
		state = STATE.IDLE
		state_idle()
	

	
	velocity.x = speed * movement.x
	velocity.z = speed * movement.z
	velocity.y -= gravity
	move_and_slide()
	

func state_idle():
			
	if Input.is_action_just_pressed("attack") and not animplayer.is_playing():
		animplayer.play("attack")
	
	if Input.is_action_just_pressed("jump") and not animplayer.is_playing():
		animplayer.play("jump")
		

	
func state_moving():
	
	if Input.is_action_just_pressed("attack") and not animplayer.is_playing():
		animplayer.play("attack")
		
	if Input.is_action_just_pressed("jump") and not animplayer.is_playing():
		animplayer.play("jump")
		

		

	
func state_falling():
	pass


	


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

func get_action_input():
	pass


func do_jump():
	velocity.y = jump

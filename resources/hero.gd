extends CharacterBody3D


#const SPEED = 5.0
#const JUMP_VELOCITY = 4.5
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
#
#
##func _physics_process(delta):
##	# Add the gravity.
##	if not is_on_floor():
##		velocity.y -= gravity * delta
##
##	# Handle Jump.
##	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
##		velocity.y = JUMP_VELOCITY
##
##	# Get the input direction and handle the movement/deceleration.
##	# As good practice, you should replace UI actions with custom gameplay actions.
##	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
##	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
##	if direction:
##		velocity.x = direction.x * SPEED
##		velocity.z = direction.z * SPEED
##	else:
##		velocity.x = move_toward(velocity.x, 0, SPEED)
##		velocity.z = move_toward(velocity.z, 0, SPEED)
##
##	move_and_slide()





@export var speed : float = 5.0

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
	

	
	if not is_on_floor():
		velocity.y -= 9.8 * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = 5

	match state:
		STATE.IDLE:
			state = state_idle()
		STATE.MOVING:
			state = state_moving()
		STATE.FALLING:
			state = state_falling()
			



func state_idle():

	if velocity.length() == 0:
		return STATE.IDLE
	else:
		return STATE.MOVING
	
func state_moving():
	move_and_slide()
	
	if velocity.length() == 0:
		return STATE.IDLE
	else:
		return STATE.MOVING

	
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
	#orientation = orientation.normalized()
	
	input = (orientation * input.z) + (orientation.cross(Vector3.UP) * input.x)
	
	
	if input.length() > 1:
		input = input.normalized()
		
		
		
	return input

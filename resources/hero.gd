extends CharacterBody3D

@export var speed : float = 5.0
@export var jump : float = 5.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") / ProjectSettings.get_setting("physics/common/physics_ticks_per_second")


enum STATE {STANDING, MOVING, FALLING}
enum ACTION {ATTACK, JUMP, LAND}
var state = STATE.STANDING
var action = null


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
	
	action = get_action_input()

	match state:
		STATE.STANDING:
			state = state_standing(movement)
		STATE.MOVING:
			state = state_moving(movement)
		STATE.FALLING:
			state = state_falling(movement)
			

	
	velocity.x = speed * movement.x
	velocity.z = speed * movement.z
	velocity.y -= gravity
	move_and_slide()
	

func state_standing(movement):
		
	if not is_on_floor():
		return STATE.FALLING
	elif movement.length() > 0:
		return STATE.MOVING
		
	match action:
		ACTION.JUMP:
			animplayer.play("jump")
		ACTION.ATTACK:
			animplayer.play("attack")
			print("attacking while standing")


	return STATE.STANDING

		

	
func state_moving(movement): 
	
	if not is_on_floor():
		return STATE.FALLING
	elif movement.length() > 0:
		return STATE.STANDING
		
	match action:
		ACTION.JUMP:
			animplayer.play("jump")
		ACTION.ATTACK:
			animplayer.play("attack")
			print("attacking while moving")
	
	return STATE.MOVING


		

	
func state_falling(movement):
	
	if is_on_floor() and movement.length() > 0:
		return STATE.MOVING
	elif is_on_floor():
		return STATE.STANDING
	
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
	
	if Input.is_action_just_pressed("attack"):
		print("attack input received")
		return ACTION.ATTACK
		
	if Input.is_action_just_pressed("jump"):
		return ACTION.JUMP
		
		
	pass


func do_jump():
	velocity.y = jump

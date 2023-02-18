extends CharacterBody3D

@export var speed : float = 5.0
@export var jump : float = 5.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") / ProjectSettings.get_setting("physics/common/physics_ticks_per_second")
var action = null


@onready var animplayer : AnimationPlayer = $AnimationPlayer
@onready var statemachine : StateMachine = $HeroStateMachine


func _ready():
	pass # Replace with function body.



func _process(delta):
	pass


func _physics_process(delta):
	var movement = get_movement_input()
	look_at(global_transform.origin + movement)
	
	
	velocity.x = speed * movement.x
	velocity.z = speed * movement.z
	if is_on_wall():
		var collider = get_last_slide_collision().get_collider()
		var collider_shape = get_last_slide_collision().get_collider_shape().shape
		if collider is StaticBodyLadder:
			if transform.origin.y < (collider.transform.origin.y + collider_shape.size.y - 1):
				velocity.x = 0
				velocity.z = 0
				velocity.y = Input.get_action_strength("move_up") - Input.get_action_strength("move_down")#
			
	else:
		velocity.y -= gravity
	move_and_slide()
	


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

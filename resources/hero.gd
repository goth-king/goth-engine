extends CharacterBody3D

@export var speed : float = 5.0
@export var jump : float = 5.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") / ProjectSettings.get_setting("physics/common/physics_ticks_per_second")
var action = null
var input : Vector3
var facing : Vector3


@onready var animplayer : AnimationPlayer = $AnimationPlayer
@onready var statemachine : StateMachine = $HeroStateMachine


func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _physics_process(delta):
	var movement = get_movement_input()
	
	if movement.length() > 0:
		look_at(global_transform.origin + movement)
		facing = movement.normalized()
	
	velocity.y -= gravity
	velocity.x = speed * movement.x
	velocity.z = speed * movement.z
	
	if is_on_wall():
		var wall = get_last_slide_collision()
		var wall_body = wall.get_collider()
		var wall_height = wall.get_collider_shape().shape.get_debug_mesh().get_aabb().size.y
		var wall_normal = get_wall_normal()
		var climb_movement
		
		#pushing toward the wall causes climbing up, pulling away causes climbing down
		#will be replaced with code only triggering climbing if pushing against wall at a near perpendicular angle
		if movement.dot(wall_normal) < 0:
			climb_movement = movement.length()
		else:
			climb_movement = -1 * movement.length()
		
		#Will be replaced with a state machine
		#clean up movement (make character climb straight up the center of the ladder, straight up ledges), tie into animationtree
		if wall_body is Platform:
			velocity.y = climb_movement
			velocity.x = 0
			velocity.z = 0
		if wall_body is Ladder: 
			velocity.y = climb_movement
			velocity.x = 0
			velocity.z = 0
		elif wall_body is Stairs:
			velocity.y = climb_movement
		else:
			velocity.y = climb_movement
	

	
	move_and_slide()
	
#rotates movement input based on camera view angle
func get_movement_input():
	
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

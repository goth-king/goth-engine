extends CharacterBody3D
class_name Animal


@export var speed = 3
@export var jump_velocity = 4.5
@export var sight_radius = 5.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") / ProjectSettings.get_setting("physics/common/physics_ticks_per_second")

enum State {idle,running,jumping,climbing,crawling}
var state = State.idle

var movement = Vector3(0,0,0)

func _ready():
	pass


func _physics_process(delta):
	pass
	
func move():
	var oldstate = state
	
	match state:
		State.idle:
			state = idle_loop()
		State.running:
			state = running_loop()
		State.jumping:
			state = jumping_loop()
		State.climbing:
			state = climbing_loop()
		State.crawling:
			state = crawling_loop()
	
	if oldstate != state:
		print("new state = ", state)

func idle_loop():
	if not is_on_floor():
		return State.jumping
	if movement.length():
		return State.running
	else: 
		return State.idle
	
func running_loop():
	if not is_on_floor():
		return State.jumping
	if not movement.length():
		return State.idle
	else:
		velocity = speed * movement
		look_at(position + movement)
		move_and_slide()
		return State.running
	
func jumping_loop():
	if is_on_floor():
		return State.idle
	else:
		velocity.y -= gravity
		move_and_slide()
		return State.jumping
	
func climbing_loop():
	#tbd
	return State.climbing
	
func crawling_loop():
	#tbd
	return State.crawling

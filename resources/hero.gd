extends CharacterBody3D

@export var speed : float = 5.0
@export var jump : float = 5.0
@export var max_climb : float = PI/6

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") / ProjectSettings.get_setting("physics/common/physics_ticks_per_second")
var action = null
var input : Vector3
var facing : Vector3
var movement : Vector3
var collider : CollisionObject3D
var collision : KinematicCollision3D

enum STATE {STAND, RUN, CLIMB, FALL}
var state = STATE.STAND

@onready var animplayer : AnimationPlayer = $AnimationPlayer
@onready var statemachine : StateMachine = $HeroStateMachine

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _physics_process(delta):
	
	set_collider()

	movement = PlayerInput.get_movement_vector()
			
	match state:
		STATE.STAND:
			state = standing()
		STATE.RUN:
			state = running()
		STATE.CLIMB:
			state = climbing()
		STATE.FALL:
			state = falling()

func standing():
	if not is_on_floor():
		return STATE.FALL
	if movement.length() > 0:
		return STATE.RUN
	return STATE.STAND

func running():
	
	if collider is Ladder:
		return STATE.CLIMB
	if movement.length() == 0:
		return STATE.STAND
	else:		
		velocity.y -= gravity
		velocity.x = speed * movement.x
		velocity.z = speed * movement.z
		move_and_slide()
		return STATE.RUN

#climbing doesn't work
func climbing():
	if collider is Ladder:
		if movement.dot(collision.get_normal()) < 0:
			velocity.x = collider.position.x - position.x
			velocity.z = collider.position.z - position.z
			velocity.y = 1
			move_and_slide()
			return STATE.CLIMB
		elif movement.dot(collision.get_normal()) > 0:
			if is_on_floor():
				velocity.y -= gravity
				velocity.x = speed * movement.x
				velocity.z = speed * movement.z
				move_and_slide()
				return STATE.RUN
			else:
				velocity.x = collider.position.x - position.x
				velocity.z = collider.position.z - position.z
				velocity.y = -1
				move_and_slide()
				return STATE.CLIMB
		else:
			collider = null
			return STATE.RUN
	else:
		return STATE.FALL
		
		
func falling():
	move_and_slide()
	if is_on_floor():
		return STATE.STAND
	else:
		velocity.y -= gravity
		return STATE.FALL
	

#checks all collisions for Ladder or Platform
func set_collider():
	var new_collider
	var touched = false
	
	var collision_count = get_slide_collision_count()
	
	if collision_count:
		#looks for collisions with specified classes
		for i in range(collision_count):
			if touched == false:
				collision = get_slide_collision(i)
				new_collider = collision.get_collider()
				if (collider != new_collider) and (new_collider is Ladder or new_collider is Platform):
					collider = new_collider
					touched = true
					print(Time.get_ticks_msec()," ", collider, " touched collider")
	else:
		collider = null
		collision = null

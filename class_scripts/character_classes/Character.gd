extends CharacterBody3D
class_name Character

@export var base_speed = 3
@export var jump_height = 2




var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") / ProjectSettings.get_setting("physics/common/physics_ticks_per_second")
var jump_speed = sqrt(16 * gravity * jump_height)

# Called when the node enters the scene tree for the first time.
func _ready():
		pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func travel(movement : Vector3, speed_multiplier : float):
	velocity.y -= gravity
	velocity.x = base_speed * movement.x * speed_multiplier
	velocity.z = base_speed * movement.z * speed_multiplier
	move_and_slide()
	turn(movement)

func turn(heading : Vector3):
	look_at(Vector3(position.x + heading.x, position.y, position.z + heading.z))
	
func pursue(movement: Vector3, speed_multiplier: float):
	pass
	

func jump():
	velocity.y = jump_speed

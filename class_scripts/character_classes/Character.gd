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
	

func move(movement : Vector3, speed_multiplier : int):
	velocity.y -= gravity
	velocity.x = base_speed * movement.x
	velocity.z = base_speed * movement.z
	move_and_slide()
	look_at(Vector3(position.x + movement.x, position.y, position.z + movement.z))

func jump():
	velocity.y = jump_speed

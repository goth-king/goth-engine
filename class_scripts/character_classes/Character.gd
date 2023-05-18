extends CharacterBody3D
class_name Character

@export var base_speed : float = 3.0
@export var jump_height : float = 2.0
@export var hit_points : float = 10 




var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") / ProjectSettings.get_setting("physics/common/physics_ticks_per_second")
var jump_speed = sqrt(16 * gravity * jump_height)

# Called when the node enters the scene tree for the first time.
func _ready():
		pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func take_damage(damage):
	hit_points -= damage
	if hit_points <= 0:
		queue_free()

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
	
	
func spawn(scene : String):
	print("Spawning instance")
	var instance = load(scene).instantiate()
	add_child(instance)
	instance.position += Vector3(0,1,0)
	

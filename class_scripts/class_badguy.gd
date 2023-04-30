extends CharacterBody3D
class_name Badguy


var speed = 150 / ProjectSettings.get_setting("physics/common/physics_ticks_per_second")
var jump_velocity = 4.5
var sight_radius = 5.0
var max_climb = PI/6


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") / ProjectSettings.get_setting("physics/common/physics_ticks_per_second")

func _ready():
	pass


func _physics_process(delta):
	pass

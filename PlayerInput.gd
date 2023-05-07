extends CharacterInput



func _ready():
	super()
	pass # Replace with function body.


func _process(delta):
	movement = get_movement_vector()
	pass

#gets joystick (or keyboard directional keys) input
#rotates the input to be orthogonal to the camera's view angle projected onto x-z plane
func get_movement_vector():
	var joystick : Vector3
	var orientation : Vector3
	var camera : Camera3D = get_viewport().get_camera_3d()
	
	joystick.x = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
	joystick.z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if camera:
		orientation = Vector3(sin(camera.rotation.y),0,cos(camera.rotation.y))
		joystick = (orientation * joystick.z) + (orientation.cross(Vector3.UP) * joystick.x)
	
	if joystick.length() > 1:
		joystick = joystick.normalized()
		
	return joystick

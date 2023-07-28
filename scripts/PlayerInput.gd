extends CharacterInput

var joystick : Vector3


func _ready():
	pass # Replace with function body.


func _process(delta):
	movement = get_movement()
	action = get_action()

	
func get_movement():
	
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
	
func get_action():
	return Input.is_action_pressed("attack")


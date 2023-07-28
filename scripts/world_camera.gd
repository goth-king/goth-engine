extends Camera3D

@export var arm_length:float = 5.0
@export var elevation:float = 3.0

@export var target:Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var displacement:Vector3
	
	if Input.is_action_just_pressed("focus_camera") and target.facing.length() > 0:
		position = target.position + Vector3(0,elevation,0) - (arm_length * target.facing)
	
	else:
		displacement = target.position - position
		displacement.y = 0
	
		position += displacement.normalized() * (displacement.length() - arm_length)
		position.y = target.position.y + elevation
		
		look_at(target.position + Vector3.UP)
	

	



	

#@tool

class_name Ladder
extends StaticBody3D

func get_extended_class():
	return "Ladder"
	
@export_enum("0 cm:0","20 cm:20","50 cm:50","100 cm:100","150 cm:150","200 cm:200") var height : int

# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_class())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if Engine.is_editor_hint:
#		$CollisionShape3D.shape.size = Vector3(1,0.01*height,1)
#		$CollisionShape3D.transform.origin.y = transform.origin.y + 0.005 * height
		
	pass
	


class_name Ladder
extends MeshInstance3D

var height : float

func _ready():
	create_convex_collision()
	height = mesh.get_aabb().size.y

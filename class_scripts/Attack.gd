extends Area3D
class_name Attack

@export var damage : float = 2.5

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(0.25).timeout
	queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_body_entered(body):
	
	if body is Character and not body == get_parent():
		body.take_damage(damage)
		print("We hit! Character hp = ",body.hit_points)
	

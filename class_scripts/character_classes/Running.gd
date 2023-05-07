extends CharacterState
class_name Running

# Called when the node enters the scene tree for the first time.
func _ready():
	print("I am running.")
	parent.animation_tree.set("parameters/RunBlend/blend_amount",1.0)
#	pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
#
	if parent.character_input.movement.length() == 0:
		parent.state = Standing.new()

	else:		
		parent.character_body.velocity.y -= parent.character_body.gravity * delta
		parent.character_body.velocity.x = parent.character_body.base_speed * parent.character_input.movement.x
		parent.character_body.velocity.z = parent.character_body.base_speed * parent.character_input.movement.z
		parent.character_body.move_and_slide()
		parent.character_body.look_at(Vector3(parent.character_body.position.x + parent.character_input.movement.x, parent.character_body.position.y, parent.character_body.position.z + parent.character_input.movement.z))

extends CharacterState
class_name Falling

# Called when the node enters the scene tree for the first time.
func _ready():
	print("I am falling.")

## Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	parent.character_body.velocity.y -= ProjectSettings.get_setting("physics/3d/default_gravity") * delta
	parent.character_body.move_and_slide()

	if parent.character_body.is_on_floor():
		parent.state = Standing.new()

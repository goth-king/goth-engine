extends CharacterState
class_name Falling

# Called when the node enters the scene tree for the first time.
func _ready():
	print("CharacterState:Falling")

## Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	sm.character_body.velocity.y -= sm.character_body.gravity
	sm.character_body.move_and_slide()

	if sm.character_body.is_on_floor():
		sm.state = Standing.new()

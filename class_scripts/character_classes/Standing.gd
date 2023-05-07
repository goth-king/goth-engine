extends CharacterState
class_name Standing

# Called when the node enters the scene tree for the first time.
func _ready():
	print("I am standing.")
	parent.animation_tree.set("parameters/RunBlend/blend_amount",0.0)


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	if not parent.character_body.is_on_floor():
		parent.state = Falling.new()

	if parent.character_input.movement.length() > 0:
		parent.state = Running.new()

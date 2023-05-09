extends CharacterState
class_name Standing

# Called when the node enters the scene tree for the first time.
func _ready():
	accept_action = true
	print("CharacterState:Standing")
	sm.animation_tree.set("parameters/RunBlend/blend_amount",0.0)


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	if not sm.character_body.is_on_floor():
		change_state(Falling.new())

	if sm.character_input.movement.length() > 0:
		change_state(Running.new())

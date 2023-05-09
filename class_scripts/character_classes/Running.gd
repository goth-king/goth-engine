extends CharacterState
class_name Running

# Called when the node enters the scene tree for the first time.
func _ready():
	accept_action = true
	print("CharacterState:Running")
	sm.animation_tree.set("parameters/RunBlend/blend_amount",1.0)
#	pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
#
	if sm.character_input.movement.length() == 0:
		change_state(Standing.new())
		
	elif not sm.character_body.is_on_floor():
		sm.character_body.jump()
		change_state(Falling.new())

	else:		
		sm.character_body.move(sm.character_input.movement,1)

extends CharacterState
class_name Attacking


# Called when the node enters the scene tree for the first time.
func _ready():
	print("CharacterState:Attacking")
	sm.animation_tree.set("parameters/AttackShot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	await get_tree().create_timer(0.75).timeout
	change_state(Standing.new())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

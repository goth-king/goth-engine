extends CharacterState


var ladder : Ladder

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if ladder == null:
		change_state(Standing.new())
#	else:
#
#	elif sm.character_input.movement + 
#
#	pass

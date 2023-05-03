extends Animal


var action = null
var target : Node = self


func _ready():
	pass # Replace with function body.

func _process(delta):
	pass


func _physics_process(delta):
	if target != self:
		movement = (target.position - self.position).normalized()
		movement.y = 0
	move()




func _on_area_3d_body_entered(body):
	if body is Hero:
		target = body



func _on_reach_box_body_entered(body):
	if body is Hero:
		$AnimationTree.set("parameters/AttackShot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

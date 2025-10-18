extends Area2D

func _ready():
	self.body_entered.connect(on_body_entered)
	
func on_body_entered(body):
	if body.is_in_group("pedestrian"):
		body.respawn()

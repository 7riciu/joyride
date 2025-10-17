extends Area2D

var is_entered = false

func _ready() -> void:
	self.body_entered.connect(on_body_entered)
	self.body_exited.connect(on_body_exited)
	
func _process(delta: float) -> void:
	if is_entered and Input.is_action_just_pressed("interact"):
		thought()
	
func on_body_entered(body):
	if body.is_in_group("player"):
		is_entered = true
		
func on_body_exited(body):
	if body.is_in_group("player"):
		is_entered = false
		
func thought():
	print("This is a cool object")

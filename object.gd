extends Area2D

@onready var thought_rect = get_tree().get_first_node_in_group("thought rect")
@onready var thought_text = get_tree().get_first_node_in_group("thought text")

var is_entered = false
var thought_on_screen = false

func _ready() -> void:
	self.body_entered.connect(on_body_entered)
	self.body_exited.connect(on_body_exited)

func _process(_delta: float) -> void:
	if is_entered and Input.is_action_just_pressed("interact"):
		for node in get_tree().get_nodes_in_group("pause"):
			node.movement_paused = true
		thought()
		
	if thought_on_screen and Input.is_action_just_pressed("skip"):
		thought_rect.visible = false
		thought_text.visible = false
		thought_on_screen = false
		for node in get_tree().get_nodes_in_group("pause"):
			node.movement_paused = false

func on_body_entered(body):
	if body.is_in_group("player"):
		is_entered = true

func on_body_exited(body):
	if body.is_in_group("player"):
		is_entered = false

func thought():
	thought_rect.visible = true
	thought_text.visible = true
	thought_on_screen = true
	
	thought_text.text = "This is interesting"

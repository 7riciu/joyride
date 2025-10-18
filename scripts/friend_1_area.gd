extends Area2D

@onready var speech_rect = get_tree().get_first_node_in_group("thought rect")
@onready var speech_text = get_tree().get_first_node_in_group("thought text")
@onready var friend_parent = get_tree().get_first_node_in_group("friend 1")

var speech_on_screen = true
var is_entered = false
var following = false

func _ready() -> void:
	self.body_entered.connect(on_body_entered)
	self.body_exited.connect(on_body_exited)
	
func on_body_entered(body):
	if body.is_in_group("player"):
		is_entered = true
	
func on_body_exited(body):
	if body.is_in_group("player"):
		is_entered = false
	
func _process(_delta: float) -> void:
	if is_entered and Input.is_action_just_pressed("interact"):
		for node in get_tree().get_nodes_in_group("pause"):
			node.movement_paused = true
		speech()
		
	if speech_on_screen and Input.is_action_just_pressed("skip"):
		speech_rect.visible = false
		speech_text.visible = false
		speech_on_screen = false
		for node in get_tree().get_nodes_in_group("pause"):
			node.movement_paused = false
			following = true
			
func speech():
	speech_rect.visible = true
	speech_text.visible = true
	speech_on_screen = true
	
	speech_text.text = "This is interesting"

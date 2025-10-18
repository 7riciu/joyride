extends Area2D

@onready var player_sprite = get_tree().get_first_node_in_group("player")
@onready var door_teleport = get_tree().get_first_node_in_group("door room")
var is_entered = false

func _ready() -> void:
	self.body_entered.connect(on_body_entered)
	self.body_exited.connect(on_body_exited)

func _process(_delta: float) -> void:
	if is_entered and Input.is_action_just_pressed("interact"):
		get_tree().change_scene_to_file("res://scenes/start_room.tscn")

func on_body_entered(body):
	if body.is_in_group("player"):
		is_entered = true

func on_body_exited(body):
	if body.is_in_group("player"):
		is_entered = false

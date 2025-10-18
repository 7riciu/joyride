extends CharacterBody2D

@onready var player_sprite = get_tree().get_first_node_in_group("player")

var keep_distance = 100
var speed = 300.0
var jump = -400.0

func _physics_process(_delta: float) -> void:
	
	if player_sprite == null:
		return

	var target_position = player_sprite.global_position
	var distance = global_position.distance_to(target_position)

	if distance > keep_distance:
		var direction = (target_position - global_position).normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

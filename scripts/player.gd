extends CharacterBody2D

@onready var player_sprite = $AnimatedSprite2D

var speed = 300.0
var deceleration = 0.1
var acceleration = 0.1
var jump_force = -400.0

var movement_paused = false

func _physics_process(_delta: float) -> void:
	
	var direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)
	
	velocity = direction * speed
		
	if movement_paused:
		velocity = Vector2(0, 0)
		
	move_and_slide()

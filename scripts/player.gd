extends CharacterBody2D

@onready var player_sprite = $AnimatedSprite2D

var speed = 300.0
var deceleration = 0.1
var acceleration = 0.1
var jump_force = -400.0

var movement_paused = false

func _physics_process(_delta: float) -> void:
	
	var direction = Input.get_axis("left", "right")
	
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, speed * acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, speed * deceleration)
		
	if direction == 1:
		player_sprite.flip_h = true
	elif direction == -1:
		player_sprite.flip_h = false
		
	if movement_paused:
		velocity.x = 0
		
	move_and_slide()

extends CharacterBody2D

@onready var spawner = get_tree().get_first_node_in_group("pedestrian spawner")
@onready var limit = get_tree().get_nodes_in_group("pedestrian limit")
@onready var player_sprite = get_tree().get_first_node_in_group("player")
@onready var bump_area = $BumpArea
@onready var thought_rect = get_tree().get_first_node_in_group("thought rect")
@onready var thought_text = get_tree().get_first_node_in_group("thought text")

var is_bumped = false
var movement_paused = false
var text_on_screen = false

var speed = 300.0
var direction = -1

func _ready() -> void:
	bump_area.body_entered.connect(on_body_entered)
	bump_area.body_exited.connect(on_body_exited)

func _process(_delta: float) -> void:
	if is_bumped:
		movement_paused = true
		player_sprite.movement_paused = true
		dialog()
		
	if text_on_screen and Input.is_action_just_pressed("skip"):
		movement_paused = false
		player_sprite.movement_paused = false
		thought_rect.visible = false
		thought_text.visible = false
		text_on_screen = false
		bump_area.monitoring = false
		await get_tree().create_timer(3).timeout
		bump_area.monitoring = true

func _physics_process(_delta: float) -> void:
	velocity.x = speed * direction

	if movement_paused:
		return
		
	move_and_slide()

func on_body_entered(body):
	if body.is_in_group("player"):
		is_bumped = true

func on_body_exited(body):
	if body.is_in_group("player"):
		is_bumped = false
		
func dialog():
	thought_rect.visible = true
	thought_text.visible = true
	text_on_screen = true
	thought_text.text = "Watch yourself!"
	
func respawn():
	global_position = spawner.global_position
	velocity.x = 0
	print("Pedestrian respawned")

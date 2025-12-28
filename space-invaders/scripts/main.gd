extends Node2D

@onready var player = get_node_or_null("player")
var shoot_cd = true
var bullets
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bullets = get_node_or_null("bullets")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global. shoote and shoot_cd:
		create_bullet_player()
	if bullets:
		for bullet in bullets. get_children():
			bullet. position. y -= Global. speed * delta * Global. bullet_speed_mult
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left"):
		Global. left = true
	if event. is_action_released("left"):
		Global. left = false
	if event.is_action_pressed("right"):
		Global. right = true
	if event. is_action_released("right"):
		Global. right = false
	if event. is_action_pressed("shoot"):
		Global. shoote = true
	if event. is_action_released("shoot"):
		Global. shoote = false

func create_bullet_player():
	shoot_cd = false
	if bullets:
		var bullet = load("res://scenes/player_bullet.tscn").instantiate()
		bullets. add_child(bullet)
		bullet. position = Global. pos_player
	await get_tree().create_timer(0.8).timeout
	shoot_cd = true

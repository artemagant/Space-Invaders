extends Node2D

@onready var player = get_node_or_null("player")
var shoot_cd = true
var player_bullets
var enemy_bullets
var current_level = null
var is_loading_level = false  # Флаг для предотвращения двойной загрузки

func _ready() -> void:
	while Global. level > Global. level_cap:
		Global. level -= Global. level_cap
		Global.speed = min(750, Global. speed+100)
	load_level(Global.level)
	Global.speed = min(750, Global. speed)

func _process(delta: float) -> void:
	if Global.shoote and shoot_cd:
		create_bullet_player()
	if player_bullets:
		for bullet in player_bullets.get_children():
			bullet.position.y -= Global.speed * delta * Global.bullet_speed_mult
	if Global.next_level and not is_loading_level:  # Проверяем флаг
		Global.next_level = false  # Сбрасываем флаг сразу
		Global.level += 1
		if Global.level <= Global.level_cap:
			load_level(Global.level)
		else:
			Global.level = 1
			Global.speed = min(750, Global. speed+100)
			load_level(Global.level)
	if Global. life <= 0:
		Global. life = 5
		Global. level = 1
		Global. speed = 200
		load_level(Global. level)
	$health.text = str(Global. life)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left"):
		Global.left = true
	if event.is_action_released("left"):
		Global.left = false
	if event.is_action_pressed("right"):
		Global.right = true
	if event.is_action_released("right"):
		Global.right = false
	if event.is_action_pressed("shoot"):
		Global.shoote = true
	if event.is_action_released("shoot"):
		Global.shoote = false

func create_bullet_player():
	shoot_cd = false
	if player_bullets:
		var bullet = load("res://scenes/player_bullet.tscn").instantiate()
		player_bullets.add_child(bullet)
		bullet.position = Global.pos_player
		bullet.name = "player_bullet"
	
	var base_delay = Global. player_base_dalay
	var speed_multiplier = Global.speed / 100.0
	var shoot_delay = max(0.1, base_delay / speed_multiplier)*2
	
	await get_tree().create_timer(shoot_delay).timeout
	shoot_cd = true
	

func load_level(level_num):
	is_loading_level = true  # Устанавливаем флаг
	
	# Удаляем старый уровень, если он существует
	if current_level:
		current_level.queue_free()
		await current_level.tree_exited  # Ждем полного удаления
	
	var level_path = "res://scenes/levels/level_%s.tscn" % level_num
	
	# Проверяем, существует ли файл уровня
	if ResourceLoader.exists(level_path):
		current_level = load(level_path).instantiate()
		add_child(current_level)
		current_level.name = "current_level"
		setup_level()
	else:
		print("Уровень не найден: ", level_path)
	
	is_loading_level = false  # Снимаем флаг

func setup_level():
	# Получаем ссылки после загрузки уровня
	player_bullets = get_node_or_null("bullets")
	enemy_bullets = get_node_or_null("enemy_bullets")

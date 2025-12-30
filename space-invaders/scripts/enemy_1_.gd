extends Area2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var base_delay = Global. player_base_dalay
	var speed_multiplier = Global.speed / 100.0
	var shoot_delay = max(3, base_delay / speed_multiplier)*2
	$Timer.wait_time = randf_range(shoot_delay-2, shoot_delay+5)
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += Global.speed * delta * Global.enemys_direction * Global.enemy_speed_mult
	if Global. enemy_bottom:
		call_deferred("down")
	for bullet in $bullets.get_children():
		bullet. position. y -= Global.speed * delta * Global.bullet_speed_mult /12
func down():
	position. y += 40
	Global. enemy_bottom = false


func _on_area_entered(area: Area2D) -> void:
	if area.name in ["player_bullet"] or (area.name.begins_with("player_bullet")):
		area. queue_free()
		queue_free()
	if area. name == "level_borders":
		Global. enemys_direction *= -1
		Global. enemy_bottom = true
	if area. name ==  "player":
		Global. life = 0

func _on_timer_timeout() -> void:
	var bullet = load("res://scenes/enemy_bullet.tscn"). instantiate()
	$bullets.add_child(bullet)
	var base_delay = Global. player_base_dalay
	var speed_multiplier = Global.speed / 100.0
	var shoot_delay = max(3, base_delay / speed_multiplier)*2
	$Timer.wait_time = randf_range(shoot_delay-2, shoot_delay+5)
